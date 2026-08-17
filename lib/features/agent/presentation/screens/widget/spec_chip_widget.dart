import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SpecChip({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 12.sp, color: AppColor.greyColor(context)),
            Gap(4.w),
            Text(
              label,
              style: AppTextStyle.bodySmall(
                context,
              ).copyWith(color: AppColor.greyColor(context), fontSize: 10.sp),
            ),
          ],
        ),
        Gap(2.h),
        Text(
          value,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
