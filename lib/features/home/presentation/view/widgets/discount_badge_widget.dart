import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({required this.discount});

  final String discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.redColor(context),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$discount OFF',
        style: AppTextStyle.bodySmall(
          context,
        ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w900),
      ),
    );
  }
}
