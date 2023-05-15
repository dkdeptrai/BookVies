import 'package:bloc/bloc.dart';
import 'package:bookvies/models/comment_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/services/review_service.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'description_review_list_event.dart';
part 'description_review_list_state.dart';

class DescriptionReviewListBloc
    extends Bloc<DescriptionReviewListEvent, DescriptionReviewListState> {
  DescriptionReviewListBloc() : super(DescriptionReviewListInitial()) {
    on<LoadDescriptionReviewList>(_onLoadDescriptionReviewList);
    on<AddCommentEvent>(_onCommentEvent);
    on<AddReviewEvent>(_onAddReviewEvent);
  }

  _onLoadDescriptionReviewList(event, emit) async {
    emit(DescriptionReviewListLoading());
    try {
      List<Review> reviews = [];

      reviews = await ReviewService()
          .getReviews(mediaId: event.mediaId, mediaType: event.mediaType);

      emit(DescriptionReviewListLoaded(
          reviews: reviews, lastUpdated: DateTime.now()));
    } catch (e) {
      emit(DescriptionReviewListError(message: e.toString()));
    }
  }

  _onCommentEvent(event, emit) async {
    try {
      final doc = reviewsRef.doc(event.reviewId).collection('comments').doc();

      Comment comment = Comment(
          id: doc.id,
          userId: currentUser!.uid,
          userName: "Tien Vi",
          userAvatarUrl:
              "https://images.unsplash.com/photo-1488371934083-edb7857977df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=380&q=80",
          mediaId: event.mediaId,
          reviewId: event.reviewId,
          content: event.comment,
          createdTime: DateTime.now());
      await doc.set(comment.toMap());

      if (state is DescriptionReviewListLoaded) {
        final reviews = (state as DescriptionReviewListLoaded).reviews;
        final index =
            reviews.indexWhere((element) => element.id == event.reviewId);
        reviews[index].comments = [
          comment,
          ...reviews[index].comments,
        ];
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));
        print(reviews[index].comments);
      }

      showSnackBar(context: event.context, message: "Add comment successfully");
    } catch (error) {
      emit(DescriptionReviewListError(message: error.toString()));
    }
  }

  _onAddReviewEvent(event, emit) async {
    final reviewService = ReviewService();
    try {
      final Review? review = await reviewService.addReview(
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        mediaName: event.mediaName,
        mediaImage: event.mediaImage,
        mediaAuthor: event.mediaAuthor,
        rating: event.rating,
        title: event.title,
        description: event.description,
        privacy: event.privacy,
      );

      if (state is DescriptionReviewListLoaded && review != null) {
        final reviews = (state as DescriptionReviewListLoaded).reviews;
        reviews.insert(0, review);
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));
      }

      showSnackBar(context: event.context, message: "Add review successfully");

      // Update rating in book document after add review completely
      reviewService.updateRatingAfterAddReview(
          mediaId: event.mediaId, newRating: event.rating);
    } catch (error) {
      emit(DescriptionReviewListError(message: error.toString()));
    }
  }
}
