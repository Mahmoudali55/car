import 'dart:ui';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterApplyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterApplyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: 30.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor(context),
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 8,
          shadowColor: AppColor.primaryColor(
            context,
          ).withOpacity(0.4),
        ),
        child: Text(
          AppLocaleKey.applyFilter.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
