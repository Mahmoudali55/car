import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StatCard extends StatelessWidget {
  final int count;
  final String label;
  final Color dotColor;
  final BuildContext context;

  const StatCard({
    required this.count,
    required this.label,
    required this.dotColor,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(context),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.07)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            Gap(6.h),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.blackTextColor(context),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColor.blackTextColor(context).withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
