import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InspectionReportWidget extends StatelessWidget {
  const InspectionReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitleWidget(title: AppLocaleKey.inspectionReport.tr()),
            Text(
              AppLocaleKey.excellentRating.tr(),
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Gap(16.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColor.secondAppColor(context),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              _buildReportRow(context, AppLocaleKey.engineTransmissionCondition.tr(), true),
              _buildReportDivider(context),
              _buildReportRow(context, AppLocaleKey.chassisPaintCondition.tr(), true),
              _buildReportDivider(context),
              _buildReportRow(context, AppLocaleKey.interiorCleanliness.tr(), true),
              _buildReportDivider(context),
              _buildReportRow(context, AppLocaleKey.tiresBrakes.tr(), true),
              Gap(20.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.primaryColor(context),
                    side: BorderSide(color: AppColor.primaryColor(context)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    AppLocaleKey.fullReport.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReportRow(BuildContext context, String title, bool isHealthy) {
    return Row(
      children: [
        Icon(
          isHealthy ? Icons.check_circle_rounded : Icons.warning_rounded,
          color: isHealthy ? Colors.greenAccent : Colors.orangeAccent,
          size: 20.sp,
        ),
        Gap(12.w),
        Text(
          title,
          style: AppTextStyle.bodyMedium(context).copyWith(color: AppColor.blackTextColor(context)),
        ),
        const Spacer(),
        Text(
          isHealthy ? AppLocaleKey.salem.tr() : AppLocaleKey.attention.tr(),
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.9)),
        ),
      ],
    );
  }

  Widget _buildReportDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(color: AppColor.blackTextColor(context).withOpacity(0.05), height: 1),
    );
  }
}
