import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/report_model.dart';
import 'package:bookvies/services/report_service.dart';
import 'package:bookvies/services/review_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdminReportScreen extends StatefulWidget {
  const AdminReportScreen({super.key});

  @override
  State<AdminReportScreen> createState() => _AdminReportScreenState();
}

class _AdminReportScreenState extends State<AdminReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(title: "Report")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: ReportService().getReports(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final List<Report> reports = snapshot.data as List<Report>;
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFFBF3E1),
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 7),
                          child: Text("Total: ${reports.length} reports"),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              final report = reports[index];

                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: report.mediaImageUrl,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(report.mediaName,
                                            style: AppStyles.subHeaderTextStyle)
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    const Text("Review",
                                        style:
                                            AppStyles.adminReportSectionHeader),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  report.reviewUserImageUrl,
                                              height: 24,
                                              width: 24,
                                              fit: BoxFit.cover),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(report.reviewUserName,
                                            style:
                                                AppStyles.adminReportUserName)
                                      ],
                                    ),
                                    const SizedBox(height: 9),
                                    Text(report.reviewTitle,
                                        style: AppStyles.reportTitle),
                                    const SizedBox(height: 4),
                                    Text(report.reviewContent,
                                        style: AppStyles.reportContent),
                                    Text("Report",
                                        style: AppStyles
                                            .adminReportSectionHeader
                                            .copyWith(
                                                color:
                                                    const Color(0xFFEB2424))),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  report.reportUserImageUrl,
                                              height: 24,
                                              width: 24,
                                              fit: BoxFit.cover),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(report.reportUserName,
                                            style:
                                                AppStyles.adminReportUserName)
                                      ],
                                    ),
                                    const SizedBox(height: 9),
                                    Text(report.reportTitle,
                                        style: AppStyles.reportTitle),
                                    const SizedBox(height: 4),
                                    Text(report.reportContent,
                                        style: AppStyles.reportContent),
                                    const SizedBox(height: 8),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () => _onConfirmReport(
                                                  reportId: report.id,
                                                  reviewId: report.reviewId),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                backgroundColor:
                                                    AppColors.mediumBlue,
                                              ),
                                              child: const Text("Confirm")),
                                          ElevatedButton(
                                              onPressed: () => _onDeleteReport(
                                                  id: report.id),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                backgroundColor:
                                                    const Color(0xFFEB2424),
                                              ),
                                              child: const Text(
                                                  "Delete this report")),
                                        ])
                                  ]);
                            },
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 10),
                            itemCount: reports.length),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  _onDeleteReport({required String id}) async {
    await ReportService().deleteReport(reportId: id);
    setState(() {});
  }

  _onConfirmReport({required String reportId, required String reviewId}) async {
    await ReportService().deleteReport(reportId: reportId);
    await ReviewService().deleteReview(id: reviewId);
    setState(() {});
  }
}
