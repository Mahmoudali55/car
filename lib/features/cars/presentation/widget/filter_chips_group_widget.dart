import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipsGroup extends StatelessWidget {
  final String groupKey;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onSelected;

  const FilterChipsGroup({
    super.key,
    required this.groupKey,
    required this.items,
    this.selectedItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: items.map((item) {
        final isSelected = selectedItem == item;
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              onSelected(null);
            } else {
              onSelected(item);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.primaryColor(context)
                  : AppColor.secondAppColor(context),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColor.blackTextColor(context).withValues(alpha: 0.1),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColor.primaryColor(
                          context,
                        ).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              item.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: isSelected ? AppColor.whiteColor(context) : AppColor.blackTextColor(context).withValues(alpha: 0.70),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
