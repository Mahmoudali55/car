import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EliteSelectionGroup extends StatelessWidget {
  final String label;
  final List<int> options;
  final int selectedValue;
  final ValueChanged<int> onSelected;
  final String suffix;

  const EliteSelectionGroup({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall(context).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 11.sp,
            letterSpacing: 1.5,
            color: AppColor.blackTextColor(context).withOpacity(0.7),
          ),
        ),
        Gap(12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: options.map((option) {
            final isSelected = option == selectedValue;
            return GestureDetector(
              onTap: () => onSelected(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 60.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColor.primaryColor(context) 
                      : AppColor.cardColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected 
                        ? AppColor.primaryColor(context) 
                        : AppColor.blackTextColor(context).withOpacity(0.05),
                    width: 1.5,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColor.primaryColor(context).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ] : [],
                ),
                child: Text(
                  '$option $suffix',
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: isSelected ? Colors.white : AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
