import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BrandCard extends StatelessWidget {
  final String brand;
  final bool isSelected;
  final VoidCallback onTap;

  const BrandCard({
    super.key,
    required this.brand,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColor.primaryColor(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: isSelected ? primary.withValues(alpha: 0.05) : AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? primary : AppColor.borderColor(context),
            width: isSelected ? 1.2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              brand[0].toUpperCase(),
              style: AppTextStyle.titleLarge(context).copyWith(
                fontWeight: FontWeight.w900,
                color: isSelected
                    ? primary
                    : AppColor.whiteColor(context).withValues(alpha: 0.2),
                fontSize: 24.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
            Gap(12.h),
            Text(
              brand.toUpperCase(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: isSelected ? AppColor.whiteColor(context) : AppColor.greyColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 10.sp,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
