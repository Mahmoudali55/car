import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomCustomerEmptyWidget extends StatelessWidget {
  const CustomCustomerEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: AppColor.hintColor(context).withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline_rounded,
              size: 48.sp,
              color: AppColor.hintColor(context),
            ),
          ),
          Gap(16.h),
          Text(
            AppLocaleKey.agentNoMatchesFound.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.hintColor(context), fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
