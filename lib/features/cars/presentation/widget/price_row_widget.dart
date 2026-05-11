import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceRowWidget extends StatelessWidget {
  const PriceRowWidget({super.key, required this.label, required this.value, this.isBold = false});
  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium(context).copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: AppColor.blackTextColor(context).withOpacity(isBold ? 0.8 : 0.6),
          ),
        ),
        Text(
          value,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: isBold ? 16.sp : 14.sp),
        ),
      ],
    );
  }
}
