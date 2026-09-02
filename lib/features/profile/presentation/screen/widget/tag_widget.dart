import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Tag extends StatelessWidget {
  const Tag({super.key, required this.label, required this.icon, required this.context});
  final String label;
  final IconData icon;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11.sp, color: AppColor.greyColor(context)),
        Gap(3.w),
        Text(
          label,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.greyColor(context), fontSize: 11.sp),
        ),
      ],
    );
  }
}
