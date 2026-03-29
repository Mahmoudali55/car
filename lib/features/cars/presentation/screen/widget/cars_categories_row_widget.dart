import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarsCategoriesRowWidget extends StatelessWidget {
  final int selectedIndex;
  final List<String> categories;
  final Function(int) onCategorySelected;

  const CarsCategoriesRowWidget({
    super.key,
    required this.selectedIndex,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => Gap(12.w),
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primaryColor(context)
                    : AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColor.blackTextColor(context).withValues(alpha: 0.05),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                categories[index],
                style: AppTextStyle.bodyMedium(context).copyWith(
                  color: isSelected
                      ? AppColor.whiteColor(context)
                      : AppColor.blackTextColor(context).withValues(alpha: 0.60),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
