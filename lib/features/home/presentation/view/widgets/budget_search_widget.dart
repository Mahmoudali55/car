import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetSearchWidget extends StatefulWidget {
  const BudgetSearchWidget({super.key});

  @override
  State<BudgetSearchWidget> createState() => _BudgetSearchWidgetState();
}

class _BudgetSearchWidgetState extends State<BudgetSearchWidget> {
  int _selectedIndex = 0; // Keep track of selected budget

  final budgets = [
    AppLocaleKey.under50k.tr(),
    AppLocaleKey.k50k100k.tr(),
    AppLocaleKey.k100k200k.tr(),
    AppLocaleKey.over200k.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: budgets.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ), // Slightly wider padding for a premium look
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primaryColor(context)
                    : AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(30.r), // Pill shape
                border: Border.all(
                  color: isSelected
                      ? AppColor.primaryColor(context)
                      : AppColor.blackTextColor(context).withOpacity(0.08),
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.primaryColor(
                            context,
                          ).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  budgets[index],
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: isSelected
                        ? AppColor.blackTextColor(context)
                        : AppColor.blackTextColor(context).withOpacity(0.8),
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
