import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EliteInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const EliteInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyle.bodySmall(context).copyWith(
            color: AppColor.greyColor(context),
            fontSize: 9.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        Gap(8.h),
        Text(
          value.toUpperCase(),
          style: AppTextStyle.bodyMedium(context).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 13.sp,
            color: AppColor.whiteColor(context),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
