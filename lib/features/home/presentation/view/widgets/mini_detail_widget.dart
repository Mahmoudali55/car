import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MiniDetailWidget extends StatelessWidget {
  const MiniDetailWidget({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.02))),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.greyColor(context), size: 14.w),
          Gap(6.w),
          Text(
            label,
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.greyColor(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
