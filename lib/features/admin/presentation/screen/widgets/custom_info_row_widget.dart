import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomInfoRowWidget extends StatelessWidget {
  const CustomInfoRowWidget({super.key, required this.icon, required this.text, this.iconColor});
  final IconData icon;
  final String text;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: iconColor ?? AppColor.blackTextColor(context).withValues(alpha: 0.3),
        ),
        Gap(12.w),
        Expanded(
          child: ValueWithCurrencyIcon(
            text: text,
            textStyle: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
