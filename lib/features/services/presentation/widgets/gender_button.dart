import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderButton extends StatelessWidget {
  final String value;
  final String label;
  final String? selectedGender;
  final ValueChanged<String> onTap;

  const GenderButton({
    super.key,
    required this.value,
    required this.label,
    required this.selectedGender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedGender == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context).withOpacity(0.08)
              : AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor(context) : AppColor.borderColor(context),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyle.bodyMedium(context).copyWith(
              fontWeight: FontWeight.w700,
              color: isSelected ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
