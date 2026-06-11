import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
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
            Gap(15.h),
            // Animated count — counts up from 0 whenever value changes
            TweenAnimationBuilder<int>(
              key: ValueKey<int>(count),
              tween: IntTween(begin: 0, end: count),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, val, _) => Text(
                '$val',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.blackTextColor(context),
                ),
              ),
            ),
            Gap(15.h),
            Text(
              label,
              style: AppTextStyle.bodySmall(
                context,
                color: AppColor.blackTextColor(context),
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
