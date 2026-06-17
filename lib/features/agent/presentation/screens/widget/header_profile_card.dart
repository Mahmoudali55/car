import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HeaderProfileCard extends StatelessWidget {
  const HeaderProfileCard({super.key, required this.customer});

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.blueColor(context), AppColor.blueColor(context).withValues(alpha: .8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blueColor(context).withValues(alpha: .3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Gap(16.h),
          Text(
            customer.customerName ?? '---',
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyLarge(context).copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              color: AppColor.whiteColor(context),
            ),
          ),
          Gap(8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColor(context).withValues(alpha: .15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              "${AppLocaleKey.agentCustomerNo.tr()} ${customer.customerNo ?? '---'}",
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
