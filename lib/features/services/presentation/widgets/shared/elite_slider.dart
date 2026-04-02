import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class EliteSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String suffix;
  final int? divisions;

  const EliteSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.suffix = '',
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColor.primaryColor(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyle.bodySmall(context).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 11.sp,
                letterSpacing: 1.5,
                color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
              ),
            ),
            Text(
              '${NumberFormat('#,##0').format(value)} $suffix',
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 12.sp,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        Gap(4.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primary,
            inactiveTrackColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
            thumbColor: AppColor.cardColor(context),
            overlayColor: primary.withValues(alpha: 0.05),
            trackHeight: 2.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r, elevation: 0),
          ),
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
