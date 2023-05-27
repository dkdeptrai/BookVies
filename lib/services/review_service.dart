import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/comment_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/services/goal_service.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewService {
  Future<Review?> addReview(
      {required BuildContext context,
      required String mediaType,
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

      final userState = context.read<UserBloc>().state;

      if (userState is UserLoaded) {
        final UserModel user = userState.user;

        final Review review = Review(
          id: doc.id,
          userId: currentUser!.uid,
          userName: user.name,
          userAvatarUrl: user.imageUrl,
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
          privacy: privacy,
        );

        await doc.set(review.toMap());

        // update challenge
        GoalService().updateReadingGoal(
            type: mediaType == MediaType.book.name
                ? GoalType.reading.name
                : GoalType.watching.name);

        return review;
      } else {
        showSnackBar(
            context: context,
            message: "Something went wrong. Please try again.");
        return null;
      }
    } catch (error) {
      print("Add review error: $error");
      return null;
    }
  }

  Future<List<Review>> getReviews(
      {required String mediaId, required String mediaType}) async {
    List<Review> reviews = [];

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
        commentsSnapshot.docs.forEach((element) {
          review.comments.add(Comment.fromMap(element.data()));
        });

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
      "numberOfReviews": book.numberReviews + 1,
      "averageRating": (book.numberReviews * book.averageRating + newRating) /
          (book.numberReviews + 1),
    });
  }

  Future<Comment?> commentOnReview(
      {required String reviewId,
      required BuildContext context,
      required String mediaId,
      required String content}) async {
    Comment? result;
    try {
      final doc = reviewsRef.doc(reviewId).collection('comments').doc();
      final userState = context.read<UserBloc>().state;

      if (userState is UserLoaded) {
        Comment comment = Comment(
            id: doc.id,
            userId: currentUser!.uid,
            userName: userState.user.name,
            userAvatarUrl: userState.user.imageUrl,
            mediaId: mediaId,
            reviewId: reviewId,
            content: content,
            createdTime: DateTime.now());
        await doc.set(comment.toMap());
        result = comment;
      } else {
        showSnackBar(
            context: context,
            message: "Something went wrong. Please try again.");
      }
    } catch (error) {
      print("Comment on review error: ${error.toString()}");
    }

    return result;
  }

  Future<void> upVoteReview({required String reviewId}) async {
    try {
      await reviewsRef.doc(reviewId).update({
        "upVoteNumber": FieldValue.increment(1),
        "upVoteUsers": FieldValue.arrayUnion([currentUser!.uid])
      });
    } catch (error) {
      print("Up vote error: ${error.toString()}");
      return Future.error(error);
    }
  }

  Future<void> deleteUpVoteReview({required String reviewId}) async {
    try {
      await reviewsRef.doc(reviewId).update({
        "upVoteNumber": FieldValue.increment(-1),
        "upVoteUsers": FieldValue.arrayRemove([currentUser!.uid])
      });
      print("Delete up vote successfully");
    } catch (error) {
      print("Delete up vote error: ${error.toString()}");
      return Future.error(error);
    }
  }

  Future<void> downVoteReview({required String reviewId}) async {
    try {
      await reviewsRef.doc(reviewId).update({
        "downVoteNumber": FieldValue.increment(1),
        "downVoteUsers": FieldValue.arrayUnion([currentUser!.uid])
      });
    } catch (error) {
      print("Down vote error: ${error.toString()}");
      return Future.error(error);
    }
  }

  Future<void> deleteDownVoteReview({required String reviewId}) async {
    try {
      await reviewsRef.doc(reviewId).update({
        "downVoteNumber": FieldValue.increment(-1),
        "downVoteUsers": FieldValue.arrayRemove([currentUser!.uid])
      });
    } catch (error) {
      print("Delete down vote error: ${error.toString()}");
      return Future.error(error);
    }
  }
}
