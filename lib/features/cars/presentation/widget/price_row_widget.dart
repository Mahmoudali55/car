import 'package:car/core/custom_widgets/custom_sar_text.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.bodyMedium(context).copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: AppColor.blackTextColor(context).withValues(alpha: (isBold ? 0.8 : 0.6)),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        ValueWithCurrencyIcon(
          text: value,
          textStyle: AppTextStyle.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: isBold ? 16.sp : 14.sp),
        ),
      ],
    );
  }
}
