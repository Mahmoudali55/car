import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentSslNoteWidget extends StatelessWidget {
  final String text;

  const PaymentSslNoteWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shield_outlined,
            color: AppColor.blackTextColor(context).withOpacity(0.4),
            size: 14.sp,
          ),
          Gap(6.w),
          Text(
            text,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.4), fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
