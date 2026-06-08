import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmploymentTypeButton extends StatelessWidget {
  final String value;
  final String label;
  final String? selectedType;
  final ValueChanged<String> onTap;

  const EmploymentTypeButton({
    super.key,
    required this.value,
    required this.label,
    required this.selectedType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedType == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 11.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context).withValues(alpha: 0.08)
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
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              color: isSelected ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
