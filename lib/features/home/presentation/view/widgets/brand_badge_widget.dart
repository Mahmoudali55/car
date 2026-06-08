import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandBadge extends StatelessWidget {
  const BrandBadge({required this.brand});

  final String brand;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: (0.12)),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: (0.25))),
      ),
      child: Text(
        brand,
        style: AppTextStyle.bodySmall(context).copyWith(
          color: AppColor.primaryColor(context),
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
