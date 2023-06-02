import 'package:bookvies/blocs/description_review_list_bloc/description_review_list_bloc.dart';
import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/extensions/double_extensions.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/chart_detail_item_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsChartWidget extends StatelessWidget {
  final double averageRating;
  const ReviewsChartWidget({super.key, required this.averageRating});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Color> colors = [
      AppColors.firstChartColor,
      AppColors.secondChartColor,
      AppColors.thirdChartColor,
      AppColors.fourthChartColor,
      AppColors.fifthChartColor,
    ];

    return BlocBuilder<DescriptionReviewListBloc, DescriptionReviewListState>(
      builder: (context, state) {
        if (state is DescriptionReviewListLoading) {
          return const ShimmerLoadingWidget(height: 200);
        } else if (state is DescriptionReviewListError) {
          return Text(state.message);
        } else if (state is DescriptionReviewListLoaded) {
          final reviews = state.reviews;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: size.width / 2,
                    width: size.width / 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(reviews: reviews),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              "${averageRating.toFixed(1)} (${reviews.length} Reviews)",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          // Text(" (${reviews.length} Reviews)")
                        ],
                      ),
                      const SizedBox(height: 5),
                      ...List.generate(
                          5,
                          (index) => ChartDetailItemWidget(
                                color: colors[index],
                                rating: index + 1,
                                quantity:
                                    countReviewsPerRating(reviews, index + 1),
                              )),
                    ],
                  )
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  int countReviewsPerRating(List<Review> reviews, int rating) {
    int count = 0;
    for (Review review in reviews) {
      if (review.rating == rating) {
        count++;
      }
    }
    return count;
  }

  List<PieChartSectionData> showingSections({required List<Review> reviews}) {
    const radius = 50.0;
    List<double> values = [
      double.parse((countReviewsPerRating(reviews, 1) / reviews.length)
          .toStringAsFixed(4)),
      double.parse((countReviewsPerRating(reviews, 2) / reviews.length)
          .toStringAsFixed(4)),
      double.parse((countReviewsPerRating(reviews, 3) / reviews.length)
          .toStringAsFixed(4)),
      double.parse((countReviewsPerRating(reviews, 4) / reviews.length)
          .toStringAsFixed(4)),
      double.parse((countReviewsPerRating(reviews, 5) / reviews.length)
          .toStringAsFixed(4)),
    ];
    List<Color> colors = [
      AppColors.firstChartColor,
      AppColors.secondChartColor,
      AppColors.thirdChartColor,
      AppColors.fourthChartColor,
      AppColors.fifthChartColor,
    ];

    if (reviews.isEmpty) {
      return List.generate(1, (index) {
        return PieChartSectionData(
          color: colors[index],
          value: 100,
          title: "0%",
          radius: radius,
          titleStyle: AppStyles.chartText,
        );
      });
    }

    return List.generate(5, (index) {
      return PieChartSectionData(
        color: colors[index],
        value: values[index],
        title: "${values[index] * 100}%",
        radius: radius,
        titleStyle: AppStyles.chartText,
      );
    });
  }
}

//Old chart
// Row(
              //   children: [
              //     Text("$averageRating "),
              //     SvgPicture.asset(AppAssets.icStar, height: 14),
              //     Text(" (${reviews.length} Reviews)")
              //   ],
              // ),
              // ListView.separated(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (_, index) => Row(
              //           children: [
              //             Expanded(
              //               child: LinearProgressIndicator(
              //                 value: reviews.isEmpty
              //                     ? 0
              //                     : countReviewsPerRating(reviews, index + 1) /
              //                         reviews.length,
              //                 minHeight: 8,
              //                 backgroundColor: AppColors.greyTextColor,
              //                 color: Colors.amber,
              //               ),
              //             ),
              //             const SizedBox(
              //               width: 8,
              //             ),
              //             Text("${countReviewsPerRating(reviews, index + 1)}")
              //           ],
              //         ),
              //     separatorBuilder: (_, index) => const SizedBox(height: 6),
              //     itemCount: 5),