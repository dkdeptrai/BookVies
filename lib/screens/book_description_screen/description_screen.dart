import 'package:bookvies/blocs/description_review_list_bloc/description_review_list_bloc.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/choose_list_dialog.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_loading_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_review_item_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_title_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/information_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/reviews_chart.dart';
import 'package:bookvies/screens/write_review_screen/write_review_screen.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
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
import '../../models/media_model.dart';

class DescriptionScreen extends StatefulWidget {
  final String mediaId;
  final String mediaType;
  const DescriptionScreen(
      {super.key, required this.mediaId, required this.mediaType});

  static const id = "/book-description-screen";

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DescriptionReviewListBloc>(context).add(
        LoadDescriptionReviewList(
            mediaId: widget.mediaId, mediaType: MediaType.book.name));
  }

  @override
  Widget build(BuildContext context) {
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
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: SvgPicture.asset(AppAssets.icShare),
            //   )
            // ],
          ),
        ),
        body: SafeArea(
            child: FutureBuilder<DocumentSnapshot>(
          future: widget.mediaType == MediaType.book.name
              ? booksRef.doc(widget.mediaId).get()
              : moviesRef.doc(widget.mediaId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            late final Media media;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error: \${snapshot.error}');
              }
              if (snapshot.data?.data() == null) {
                return Text(snapshot.data.toString());
              } else {
                if (widget.mediaType == MediaType.book.name) {
                  media = Book.fromMap(
                          snapshot.data?.data() as Map<String, dynamic>)
                      .copyWith(id: snapshot.data!.id);
                } else {
                  media = Movie.fromMap(
                          snapshot.data?.data() as Map<String, dynamic>)
                      .copyWith(id: snapshot.data!.id);
                }
              }

              return SingleChildScrollView(
                key: Key("descriptionScreenScrollable"),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                  child: Column(
                    children: [
                      DescriptionTitleWidget(media: media),
                      InformationWidget(media: media),
                      CustomButtonWithGradientBackground(
                        margin: const EdgeInsets.only(top: 34),
                        height: 53,
                        width: 200,
                        text: "Add to library",
                        onPressed: () => _showAddToLibraryDialog(media),
                      ),
                      const SizedBox(height: 30),

                      // Review's rating chart
                      ReviewsChartWidget(averageRating: media.averageRating),

                      CustomButtonWithGradientBackground(
                        margin: const EdgeInsets.only(top: 34),
                        height: 53,
                        width: 233,
                        text: "Write your review",
                        onPressed: () => _handleWriteReview(media),
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

  _handleWriteReview(Media media) {
    final reviewState = context.read<DescriptionReviewListBloc>().state;
    if (reviewState is DescriptionReviewListLoaded) {
      if (reviewState.reviews.any((element) =>
          element.userId == firebaseAuth.currentUser!.uid &&
          element.mediaId == media.id)) {
        showWarningDialog(
            context: context, message: "You have already reviewed this");
        return;
      }
    }
    Navigator.pushNamed(context, WriteReviewScreen.id, arguments: media);
  }

  _showAddToLibraryDialog(Media media) {
    showDialog(
      context: context,
      builder: (context) => ChooseListDialog(
        media: media,
      ),
    );
  }
}
