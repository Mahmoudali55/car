import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class  CustomPriceWidget extends StatelessWidget {
  const CustomPriceWidget({
    super.key,
    required this.car, required this.title, required this.price,
  });

  final Map<String, dynamic> car;
  final String title ;
  final String price ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.greyColor(context),
          ),
        ),
        Text(
              price,
              style: AppTextStyle.bodySmall(context).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.blackTextColor(context),
        ),
    ),
                  ],
                );
  }
}
