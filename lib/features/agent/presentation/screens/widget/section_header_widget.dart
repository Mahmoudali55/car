import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  final Color? color;
  const SectionHeader({super.key, required this.title, this.count, this.color});

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? AppColor.blueColor(context);
    return Row(
      children: [
        Container(
          width: 5.w,
          height: 22.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeColor,
                themeColor.withValues(alpha: (0.5)),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Gap(12.w),
        Text(
          title,
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
            letterSpacing: -0.4,
          ),
        ),
        if (count != null) ...[
          Gap(10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: (0.08)),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: themeColor.withValues(alpha: (0.15))),
            ),
            child: Text(
              '$count',
              style: TextStyle(color: themeColor, fontSize: 12.sp, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ],
    );
  }
}
