import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
            Gap(8.w),
            Text(
              title,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.9),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
