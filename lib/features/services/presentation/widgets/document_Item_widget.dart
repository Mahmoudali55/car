import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DocumentItemWidget extends StatelessWidget {
  const DocumentItemWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, color: AppColor.greenColor(context), size: 20.sp),
        Gap(10.w),
        Expanded(
          child: ValueWithCurrencyIcon(
            text: text,
            textStyle: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), height: 1.4),
          ),
        ),
      ],
    );
  }
}
