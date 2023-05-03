part of 'description_review_list_bloc.dart';

abstract class DescriptionReviewListEvent extends Equatable {
  const DescriptionReviewListEvent();

  @override
  List<Object> get props => [];
}

class LoadDescriptionReviewList extends DescriptionReviewListEvent {
  final String mediaId;
  const LoadDescriptionReviewList({required this.mediaId});

  @override
  List<Object> get props => [mediaId];
}

class AddCommentEvent extends DescriptionReviewListEvent {
  final BuildContext context;
  final String reviewId;
  final String mediaId;
  final String comment;
  const AddCommentEvent(
      {required this.context,
      required this.mediaId,
      required this.reviewId,
      required this.comment});

  @override
  List<Object> get props => [reviewId, mediaId, comment];
}

class AddReviewEvent extends DescriptionReviewListEvent {
  final BuildContext context;
  final String mediaId;
  final int rating;
  final String title;
  final String description;
  final String privacy;

  const AddReviewEvent({
    required this.context,
    required this.mediaId,
    required this.rating,
    required this.title,
    required this.description,
    required this.privacy,
  });

  @override
  List<Object> get props => [mediaId, rating, title, description, privacy];
}
