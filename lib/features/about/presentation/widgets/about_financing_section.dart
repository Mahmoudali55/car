import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AboutFinancingSection extends StatelessWidget {
  const AboutFinancingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor(context).withOpacity(0.1),
            AppColor.primaryColor(context).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_rounded, color: AppColor.primaryColor(context), size: 30.sp),
          Gap(16.w),
          Expanded(
            child: Text(
              AppLocaleKey.financingAvailable.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.9),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
