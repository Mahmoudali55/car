import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const SectionTitleWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor(context), size: 20.sp),
        Gap(8.w),
        Text(
          title,
          style: AppTextStyle.bodyLarge(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
