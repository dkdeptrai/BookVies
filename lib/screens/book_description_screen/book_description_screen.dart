import 'package:bookvies/blocs/description_review_list_bloc/description_review_list_bloc.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/choose_list_dialog.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_loading_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_review_item_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_title_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/information_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/reviews_chart.dart';
import 'package:bookvies/screens/write_review_screen/write_review_screen.dart';
import 'package:bookvies/services/review_service.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/models/book_model.dart';

import '../../constant/assets.dart';

class BookDescriptionScreen extends StatefulWidget {
  final String bookId;
  const BookDescriptionScreen({super.key, required this.bookId});

  static const id = "/book-description-screen";

  @override
  State<BookDescriptionScreen> createState() => _BookDescriptionScreenState();
}

class _BookDescriptionScreenState extends State<BookDescriptionScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DescriptionReviewListBloc>(context).add(
        LoadDescriptionReviewList(
            mediaId: widget.bookId, mediaType: MediaType.book.name));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "",
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(AppAssets.icArrowLeft)),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.icShare),
              )
            ],
          ),
        ),
        body: SafeArea(
            child: FutureBuilder<DocumentSnapshot>(
          future: booksRef.doc(widget.bookId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            late final Book book;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error: \${snapshot.error}');
              }
              if (snapshot.data?.data() == null) {
                return Text(snapshot.data.toString());
              } else {
                book =
                    Book.fromMap(snapshot.data?.data() as Map<String, dynamic>)
                        .copyWith(id: snapshot.data?.id);
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                  child: Column(
                    children: [
                      DescriptionTitleWidget(size: size, book: book),
                      InformationWidget(book: book),
                      CustomButtonWithGradientBackground(
                        margin: const EdgeInsets.only(top: 34),
                        height: 53,
                        width: 200,
                        text: "Add to library",
                        onPressed: () => _showAddToLibraryDialog(book),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),

                      // Review's rating chart
                      ReviewsChartWidget(averageRating: book.averageRating),

                      CustomButtonWithGradientBackground(
                        margin: const EdgeInsets.only(top: 34),
                        height: 53,
                        width: 233,
                        text: "Write your review",
                        onPressed: () => _navigateToWriteReviewScreen(book),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<DescriptionReviewListBloc,
                          DescriptionReviewListState>(
                        builder: (context, state) {
                          if (state is DescriptionReviewListLoading) {
                            return SpinKitFadingCircle(
                                color: AppColors.mediumBlue);
                          } else if (state is DescriptionReviewListLoaded) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.reviews.length,
                                itemBuilder: (_, index) {
                                  return DescriptionReviewItemWidget(
                                      review: state.reviews[index]);
                                });
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const DescriptionLoadingWidget(); // Show a loading indicator while data is being fetched
            }
          },
        )));
  }

  _navigateToWriteReviewScreen(Book book) {
    Navigator.pushNamed(context, WriteReviewScreen.id, arguments: book);
  }

  _showAddToLibraryDialog(Book book) {
    showDialog(
      context: context,
      builder: (context) => ChooseListDialog(
          mediaId: widget.bookId,
          image: book.image,
          name: book.name,
          author: book.author ?? ""),
    );
  }

  // Future<List<Review>> getReviews() async {
  //   final reviews = await ReviewService().getReviews(mediaId: widget.bookId);

  //   return reviews;
  // }
}
