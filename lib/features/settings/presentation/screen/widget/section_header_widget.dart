import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.bodySmall(context).copyWith(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}