import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  const InfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.color,
  });
  final String label;
  final String value;
  final bool isBold;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueWithCurrencyIcon(
          text: label,
          textStyle: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.w500),
        ),
        ValueWithCurrencyIcon(
          text: value,
          textStyle: AppTextStyle.bodyMedium(context).copyWith(
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: color ?? AppColor.blackColor(context),
          ),
        ),
      ],
    );
  }
}
