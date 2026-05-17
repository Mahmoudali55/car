import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const CommRow({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: AppColor.hintColor(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
