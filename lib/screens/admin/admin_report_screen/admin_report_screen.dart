import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:flutter/material.dart';

class AdminReportScreen extends StatelessWidget {
  const AdminReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(title: "Report")),
      body: Column(
        children: [],
      ),
    );
  }
}
