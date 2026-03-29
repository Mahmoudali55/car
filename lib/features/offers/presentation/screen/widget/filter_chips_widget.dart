import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FilterChipsWidget extends StatefulWidget {
  const FilterChipsWidget({super.key, required this.filters, required this.selectedFilterIndex});

  final List<String> filters;
  final int selectedFilterIndex;

  @override
  State<FilterChipsWidget> createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedFilterIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: widget.filters.length,
        separatorBuilder: (context, index) => Gap(12.w),
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primaryColor(context)
                    : AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(16.r),
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
                widget.filters[index],
                style: AppTextStyle.bodyMedium(context).copyWith(
                  color: isSelected
                      ? AppColor.whiteColor(context)
                      : AppColor.blackTextColor(context).withValues(alpha: 0.54),
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
