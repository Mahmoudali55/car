import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
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
            const SectionTitleWidget(title: 'تقرير الفحص'),
            Text(
              'ممتاز 4.8/5',
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
              _buildReportRow(context, 'حالة المحرك والناقل', true),
              _buildReportDivider(),
              _buildReportRow(context, 'حالة الهيكل والطلاء', true),
              _buildReportDivider(),
              _buildReportRow(context, 'الحالة الداخلية والنظافة', true),
              _buildReportDivider(),
              _buildReportRow(context, 'الإطارات والمكابح', true),
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
                  child: const Text(
                    'تحميل التقرير الكامل (PDF)',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
        Text(title, style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.white)),
        const Spacer(),
        Text(
          isHealthy ? 'سليم' : 'يحتاج انتباه',
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    );
  }

  Widget _buildReportDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
    );
  }
}
