import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InspectionReportsScreen extends StatelessWidget {
  const InspectionReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.inspectionReports.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 6,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) => _buildReportItem(context, index),
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocaleKey.reportNumber.tr()}#${1000 + index}',
                style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                '2024/03/25',
                style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.38), fontSize: 11.sp),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            '${AppLocaleKey.status.tr()}: ${AppLocaleKey.inspectionCompleted.tr()}',
            style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.70), fontSize: 12.sp),
          ),
          Gap(12.h),
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
              Gap(8.w),
              Text(
                '${AppLocaleKey.result.tr()}: 95/100 (${AppLocaleKey.excellent.tr()})',
                style: TextStyle(color: Colors.green, fontSize: 12.sp),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text(AppLocaleKey.viewFullReport.tr())),
            ],
          ),
        ],
      ),
    );
  }
}
