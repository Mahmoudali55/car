import 'package:flutter/material.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SpecBadgeWidget extends StatelessWidget {
  const SpecBadgeWidget({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.blackTextColor(context).withOpacity(0.54), size: 14.sp),
          Gap(6.w),
          Text(
            text,
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
