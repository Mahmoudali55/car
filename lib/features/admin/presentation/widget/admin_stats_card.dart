import 'dart:ui';

import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? percentage;

  const AdminStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: (0.02)),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.05))),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.blackTextColor(context).withValues(alpha: (0.04)),
                  AppColor.blackTextColor(context).withValues(alpha: (0.01)),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildIconBox(), _buildTrendIndicator(context)],
                ),
                _buildTextContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: (0.12)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(icon, color: color, size: 22.sp),
    );
  }

  Widget _buildTrendIndicator(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.greenColor(context).withValues(alpha: (0.1)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up_rounded, color: AppColor.greenColor(context), size: 12.sp),
          Gap(4.w),
          Text(
            percentage ?? '',
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.greenColor(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final intValue = int.tryParse(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (intValue != null)
          TweenAnimationBuilder<int>(
            key: ValueKey<int>(intValue),
            tween: IntTween(begin: 0, end: intValue),
            duration: const Duration(milliseconds: 3000),
            curve: Curves.easeOutCubic,
            builder: (context, val, child) {
              return Text(
                val.toString(),
                style: AppTextStyle.bodyLarge(context).copyWith(
                  color: AppColor.blackTextColor(context),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              );
            },
          )
        else
          Text(
            value,
            style: AppTextStyle.bodyLarge(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
        Gap(2.h),
        Text(
          title,
          style: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: (0.4)),
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
