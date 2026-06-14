import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class QuickInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const QuickInfo({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryColor(context)),
        Gap(8.h),
        Text(value, style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w900)),
        Gap(4.h),
        Text(
          title,
          style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
        ),
      ],
    );
  }
}
