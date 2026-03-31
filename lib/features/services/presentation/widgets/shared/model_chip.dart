import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModelChip extends StatelessWidget {
  final String model;
  final bool isSelected;
  final VoidCallback onTap;

  const ModelChip({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColor.primaryColor(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? primary.withValues(alpha: 0.1)
              : AppColor.whiteColor(context).withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? primary : AppColor.borderColor(context),
            width: 1,
          ),
        ),
        child: Text(
          model.toUpperCase(),
          style: AppTextStyle.bodySmall(context).copyWith(
            color: isSelected ? AppColor.whiteColor(context) : AppColor.greyColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 10.sp,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
