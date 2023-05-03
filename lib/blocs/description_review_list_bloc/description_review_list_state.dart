part of 'description_review_list_bloc.dart';

abstract class DescriptionReviewListState extends Equatable {
  const DescriptionReviewListState();

  @override
  List<Object> get props => [];
}

class DescriptionReviewListInitial extends DescriptionReviewListState {}

class DescriptionReviewListLoading extends DescriptionReviewListState {}

class DescriptionReviewListLoaded extends DescriptionReviewListState {
  final List<Review> reviews;
  final DateTime lastUpdated;
  const DescriptionReviewListLoaded(
      {required this.reviews, required this.lastUpdated});

  @override
  List<Object> get props => [reviews, lastUpdated];
}

class DescriptionReviewListError extends DescriptionReviewListState {
  final String message;
  const DescriptionReviewListError({required this.message});

  @override
  List<Object> get props => [message];
}
