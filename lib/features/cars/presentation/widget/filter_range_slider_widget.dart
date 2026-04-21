import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
          inactiveColor: AppColor.blackTextColor(context).withOpacity(0.1),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
