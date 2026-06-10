import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPriceWidget extends StatelessWidget {
  const CustomPriceWidget({
    super.key,
    required this.car,
    required this.title,
    required this.price,
    this.size,
    this.fontWeight,
    this.color,
  });
  final Map<String, dynamic> car;
  final String title;
  final String price;
  final int? size;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.bodySmall(context).copyWith(
            color: color ?? AppColor.greyColor(context),
            fontSize: size != null ? size!.toDouble() : 12.sp,
            fontWeight: fontWeight,
          ),
        ),
        ValueWithCurrencyIcon(
          text: price,
          textStyle: AppTextStyle.bodySmall(
            context,
          ).copyWith(fontWeight: FontWeight.w700, color: AppColor.blackTextColor(context)),
        ),
      ],
    );
  }
}
