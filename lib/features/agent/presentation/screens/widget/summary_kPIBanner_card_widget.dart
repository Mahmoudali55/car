import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SummaryKPIBannerCardWidget extends StatelessWidget {
  const SummaryKPIBannerCardWidget({
    super.key,
    required this.filteredCars,
    required this.totalPrice,
  });

  final List<CarModel> filteredCars;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.whiteColor(context).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmark_added_rounded,
              color: AppColor.whiteColor(context),
              size: 28.sp,
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocaleKey.agentTotalReservedCars.tr(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.whiteColor(context).withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4.h),
                Text(
                  AppLocaleKey.agentCarsCountSuffix.tr(
                    namedArgs: {'count': '${filteredCars.length}'},
                  ),
                  style: AppTextStyle.titleLarge(context).copyWith(
                    color: AppColor.whiteColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor(context).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor(context),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Gap(6.w),
                    Text(
                      AppLocaleKey.agentActiveBookings.tr(),
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.whiteColor(context),
                        fontWeight: FontWeight.w700,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (totalPrice > 0) ...[
                Gap(6.h),
                ValueWithCurrencyIcon(
                  text: '${totalPrice.toStringAsFixed(0)} ${AppLocaleKey.agentCurrencySar.tr()}',
                  textStyle: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w800),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
