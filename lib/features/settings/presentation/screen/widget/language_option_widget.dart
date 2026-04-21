import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageOptionWidget extends StatelessWidget {
  const LanguageOptionWidget({super.key, required this.title, required this.isSelected, required this.onTap,});
    final String title;final bool isSelected;final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return  InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context).withOpacity(0.1)
              : baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor(context) : baseColor.withOpacity(0.05),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: baseColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: AppColor.primaryColor(context), size: 20.sp),
          ],
        ),
      ),
    );
  }
}