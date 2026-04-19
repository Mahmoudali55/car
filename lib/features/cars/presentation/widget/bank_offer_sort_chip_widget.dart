import 'dart:ui';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/bank_offers_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BankOfferSortChip extends StatelessWidget {
  final String label;
  final SortOption option;
  final bool isSelected;
  final VoidCallback onTap;
  const BankOfferSortChip({
    super.key,
    required this.label,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor(context) : AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.withValues(alpha: 0.2),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColor.whiteColor(context) : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}