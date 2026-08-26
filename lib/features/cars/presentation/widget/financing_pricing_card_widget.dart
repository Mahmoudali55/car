import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingPricingCard extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onShowDetails;

  const FinancingPricingCard({required this.totalPrice, required this.onShowDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocaleKey.agentTotalPrice.tr(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 18.sp,
                      color: AppColor.blackTextColor(context),
                    ),
                    Gap(6.w),
                    ValueWithCurrencyIcon(
                      text: '${totalPrice.toStringAsFixed(2)} SAR',
                      textStyle: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onShowDetails,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2F7),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
              ),
              child: Center(
                child: Text(
                  AppLocaleKey.agentShowDetails.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
