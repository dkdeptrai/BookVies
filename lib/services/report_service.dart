import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/models/report_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportService {
  Future<void> addReport(
      {required BuildContext context,
      required Review review,
      required String reportTitle,
      required String reportContent}) async {
    try {
      final userState = context.read<UserBloc>().state;
      if (userState is UserLoaded) {
        final doc = reportsRef.doc();

        Report report = Report(
            id: doc.id,
            reportTitle: reportTitle,
            reportContent: reportContent,
            reportUserId: userState.user.id,
            reportUserName: userState.user.name,
            reportUserImageUrl: userState.user.imageUrl,
            reviewTitle: review.title,
            reviewContent: review.description,
            reviewUserId: review.userId,
            reviewUserName: review.userName,
            reviewUserImageUrl: review.userAvatarUrl);

        await doc.set(report.toMap());
      } else {
        showSnackBar(
            context: context,
            message: "Something went wrong. Please try again.");
      }
    } catch (error) {
      print("Add report error: $error");
      rethrow;
    }
  }
}
