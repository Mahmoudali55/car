import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SpecsRow extends StatelessWidget {
  const SpecsRow({super.key, required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.blackTextColor(context).withValues(alpha: 0.35);
    final rawColor = (car['color'] ?? car['Color'] ?? car['bodyColor'] ?? car['BODY_COLOR'] ?? '').toString().trim();
    final displayColor = rawColor.isNotEmpty && rawColor.toLowerCase() != 'null' ? rawColor : '—';

    return Row(
      children: [
        Icon(Icons.speed_outlined, color: mutedColor, size: 12.sp),
        Gap(4.w),
        Expanded(
          child: Text(
            '${car['mileage']} كم',
            style: AppTextStyle.bodySmall(context).copyWith(color: mutedColor, fontSize: 9.sp),
            maxLines: 1,
          ),
        ),
        Icon(Icons.palette_outlined, color: mutedColor, size: 12.sp),
        Gap(2.w),
        Text(
          displayColor,
          style: AppTextStyle.bodySmall(context).copyWith(color: mutedColor, fontSize: 9.sp),
        ),
      ],
    );
  }
}
