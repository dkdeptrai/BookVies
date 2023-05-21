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
    on<UpVote>(_onUpVote);
    on<DownVote>(_onDownVote);
  }

  _onDownVote(event, emit) {
    if (state is DescriptionReviewListLoaded) {
      final reviews = (state as DescriptionReviewListLoaded).reviews;
      final index =
          reviews.indexWhere((element) => element.id == event.reviewId);
      Review review = reviews[index];
      // store original numbers to use to revert if update data failed
      final originalDownVoteUsers = review.downVoteUsers;
      final originalDownVoteNumber = review.downVoteNumber;

      try {
        // if user have already down voted, remove it from downVoteUsers list and decrease downVoteNumber. Else
        if (review.downVoteUsers.contains(currentUser!.uid)) {
          review.downVoteUsers.remove(currentUser!.uid);
          review = review.copyWith(downVoteNumber: review.downVoteNumber - 1);
        } else {
          review.downVoteUsers.add(currentUser!.uid);
          review = review.copyWith(downVoteNumber: review.downVoteNumber + 1);
        }
        reviews[index] = review;
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));

        if (review.downVoteUsers.contains(currentUser!.uid)) {
          ReviewService().downVoteReview(reviewId: event.reviewId);
        } else {
          ReviewService().deleteDownVoteReview(reviewId: event.reviewId);
        }
      } catch (error) {
        // Revert if error occurred
        review = review.copyWith(
            downVoteNumber: originalDownVoteNumber,
            downVoteUsers: originalDownVoteUsers);
        reviews[index] = review;
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));
      }
    }
  }

  _onUpVote(event, emit) async {
    if (state is DescriptionReviewListLoaded) {
      final reviews = (state as DescriptionReviewListLoaded).reviews;
      final index =
          reviews.indexWhere((element) => element.id == event.reviewId);
      Review review = reviews[index];
      // store original numbers to use to revert if update data failed
      final originalUpVoteUsers = review.upVoteUsers;
      final originalUpVoteNumber = review.upVoteNumber;

      try {
        // if user have already up voted, remove it from upVoteUsers list and decrease upVoteNumber. Else
        if (review.upVoteUsers.contains(currentUser!.uid)) {
          review.upVoteUsers.remove(currentUser!.uid);
          review = review.copyWith(upVoteNumber: review.upVoteNumber - 1);
        } else {
          review.upVoteUsers.add(currentUser!.uid);
          review = review.copyWith(upVoteNumber: review.upVoteNumber + 1);
        }
        reviews[index] = review;
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));

        if (review.upVoteUsers.contains(currentUser!.uid)) {
          await ReviewService().upVoteReview(reviewId: event.reviewId);
        } else {
          await ReviewService().deleteUpVoteReview(reviewId: event.reviewId);
        }
      } catch (error) {
        // Revert if error occurred
        review = review.copyWith(
            upVoteNumber: originalUpVoteNumber,
            upVoteUsers: originalUpVoteUsers);
        reviews[index] = review;
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));
      }
    }
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
      Comment? comment = await ReviewService().commentOnReview(
          reviewId: event.reviewId,
          context: event.context,
          mediaId: event.mediaId,
          content: event.comment);

      // add comment to the review in bloc
      if (state is DescriptionReviewListLoaded && comment != null) {
        final reviews = (state as DescriptionReviewListLoaded).reviews;
        final index =
            reviews.indexWhere((element) => element.id == event.reviewId);
        reviews[index].comments = [
          comment,
          ...reviews[index].comments,
        ];
        emit(DescriptionReviewListLoaded(
            reviews: reviews, lastUpdated: DateTime.now()));
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
        context: event.context,
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
