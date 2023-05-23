import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/comment_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class ReviewService {
  Future<Review?> addReview(
      {required String mediaType,
      required String mediaId,
      required String mediaName,
      required String mediaImage,
      required String mediaAuthor,
      required int rating,
      required String title,
      required String description,
      required String privacy}) async {
    try {
      final doc = reviewsRef.doc();

      // TODO: Retrieve user data and replace these properties
      final Review review = Review(
          id: doc.id,
          userId: currentUser!.uid,
          userName: "Tien Vi",
          userAvatarUrl:
              "https://images.unsplash.com/photo-1488371934083-edb7857977df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=380&q=80",
          mediaType: mediaType,
          mediaId: mediaId,
          mediaName: mediaName,
          mediaImage: mediaImage,
          mediaAuthor: mediaAuthor,
          rating: rating.toInt(),
          title: title,
          description: description,
          upVoteNumber: 0,
          upVoteUsers: [],
          downVoteNumber: 0,
          downVoteUsers: [],
          comments: [],
          createdTime: DateTime.now(),
          privacy: privacy);

      await doc.set(review.toMap());
      return review;
    } catch (error) {
      print("Add review error: $error");
      return null;
    }
  }

  Future<List<Review>> getReviews(
      {required String mediaId, required String mediaType}) async {
    List<Review> reviews = [];

    print(PrivacyValues.public.name.toUpperCase());
    try {
      final snapshot = await reviewsRef
          .where('mediaId', isEqualTo: mediaId)
          .where("mediaType", isEqualTo: mediaType)
          .where("privacy", isEqualTo: PrivacyValues.public.name.toUpperCase())
          .orderBy('createdTime', descending: true)
          .get();

      for (final doc in snapshot.docs) {
        Review review = Review.fromMap(doc.data() as Map<String, dynamic>);

        // get comments of this review
        final commentsSnapshot = await reviewsRef
            .doc(review.id)
            .collection('comments')
            .orderBy('createdTime', descending: true)
            .get();
        for (var element in commentsSnapshot.docs) {
          review.comments.add(Comment.fromMap(element.data()));
        }

        reviews.add(review);
      }
    } catch (error) {
      print("Get reviews error: $error");
    }

    return reviews;
  }

  Future<void> updateRatingAfterAddReview(
      {required String mediaId, required int newRating}) async {
    final ref = booksRef.doc(mediaId);
    final bookSnapshot = await ref.get();
    final book = Book.fromMap(bookSnapshot.data() as Map<String, dynamic>);
    await ref.update({
      "numberReviews": book.numberReviews + 1,
      "averageRating": (book.numberReviews * book.averageRating + newRating) /
          (book.numberReviews + 1),
    });
  }
}
