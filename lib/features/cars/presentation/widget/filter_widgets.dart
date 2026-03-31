import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const FilterSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            title,
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

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

class FilterRangeSlider extends StatelessWidget {
  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;
  final bool isPrice;

  const FilterRangeSlider({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isPrice
                  ? '${values.start.toInt().toString()} ${AppLocaleKey.sar.tr()}'
                  : values.start.toInt().toString(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.primaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isPrice
                  ? '${values.end.toInt().toString()} ${AppLocaleKey.sar.tr()}'
                  : values.end.toInt().toString(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.primaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: isPrice ? 100 : (max - min).toInt(),
          activeColor: AppColor.primaryColor(context),
          inactiveColor: AppColor.blackTextColor(context).withValues(alpha: 0.1),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class FilterCheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const FilterCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColor.blackTextColor(context).withValues(alpha: 0.24)),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.70)),
        ),
        activeColor: AppColor.primaryColor(context),
        checkColor: AppColor.whiteColor(context),
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.trailing,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}

class FilterApplyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterApplyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: 30.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor(context),
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 8,
          shadowColor: AppColor.primaryColor(
            context,
          ).withValues(alpha: 0.4),
        ),
        child: Text(
          AppLocaleKey.applyFilter.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
