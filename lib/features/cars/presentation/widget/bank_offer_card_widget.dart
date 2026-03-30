import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankOffer {
  final String nameKey;
  final String logoText; // Placeholder for logo representation
  final double apr;
  final Color brandColor;

  BankOffer({
    required this.nameKey,
    required this.logoText,
    required this.apr,
    required this.brandColor,
  });

  // Calculate monthly installment and total amount based on user inputs
  Map<String, double> calculate(num carPrice, num downPayment, int durationYears) {
    final principal = (carPrice - downPayment).toDouble();
    if (principal <= 0) {
      return {'totalAmount': 0, 'monthlyInstallment': 0};
    }
    final totalProfit = principal * (apr / 100) * durationYears;
    final totalAmount = principal + totalProfit;
    final monthlyInstallment = totalAmount / (durationYears * 12);

    return {
      'totalAmount': totalAmount,
      'monthlyInstallment': monthlyInstallment,
    };
  }
}

class BankOfferCardWidget extends StatelessWidget {
  final BankOffer offer;
  final num carPrice;
  final num downPayment;
  final int durationYears;

  const BankOfferCardWidget({
    super.key,
    required this.offer,
    required this.carPrice,
    required this.downPayment,
    required this.durationYears,
  });

  @override
  Widget build(BuildContext context) {
    final calculations = offer.calculate(carPrice, downPayment, durationYears);
    final totalAmount = calculations['totalAmount'] ?? 0.0;
    final monthlyInstallment = calculations['monthlyInstallment'] ?? 0.0;

    // Number format for currency
    final formatter = NumberFormat('#,##0', 'en_US');

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          // Header: Bank Logo/Name and Profit Margin
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: offer.brandColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: offer.brandColor,
                        radius: 20.r,
                        child: Text(
                          offer.logoText,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          offer.nameKey.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackTextColor(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.percent_rounded, size: 14.sp, color: offer.brandColor),
                      SizedBox(width: 4.w),
                      Text(
                        '${offer.apr}% ${AppLocaleKey.profitMargin.tr()}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: offer.brandColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Body: Calculations
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.monthlyInstallment.tr(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${formatter.format(monthlyInstallment)} SAR',
                        style: TextStyle(
                          color: AppColor.primaryColor(context),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 40.h,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocaleKey.totalAmount.tr(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${formatter.format(totalAmount)} SAR',
                          style: TextStyle(
                            color: AppColor.blackTextColor(context),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
