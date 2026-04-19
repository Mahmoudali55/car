import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

enum SortOption { lowestMargin, highestMargin, lowestInstallment }
class BankOfferCalculatorCard extends StatelessWidget {
  final num carPrice;
  final double downPayment;
  final int durationYears;
  final TextEditingController downPaymentController;
  final ValueChanged<String> onDownPaymentChanged;
  final ValueChanged<double> onDurationChanged;
  const BankOfferCalculatorCard({
    super.key,
    required this.carPrice,
    required this.downPayment,
    required this.durationYears,
    required this.downPaymentController,
    required this.onDownPaymentChanged,
    required this.onDurationChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocaleKey.totalAmount.tr()}:',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
              Text(
                '${NumberFormat('#,##0', 'en_US').format(carPrice)} ${AppLocaleKey.sar.tr()}',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Gap(20.h),
          Text(
            AppLocaleKey.downPayment.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColor.blackTextColor(context),
            ),
          ),
          Gap(8.h),
          TextField(
            controller: downPaymentController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColor.blackTextColor(context)),
            decoration: InputDecoration(
              hintText: '0 ${AppLocaleKey.sar.tr()}',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: AppColor.scaffoldColor(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
            onChanged: onDownPaymentChanged,
          ),
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocaleKey.durationInYears.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColor.blackTextColor(context),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$durationYears',
                  style: TextStyle(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: durationYears.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            activeColor: AppColor.primaryColor(context),
            inactiveColor: Colors.grey.withValues(alpha: 0.2),
            onChanged: onDurationChanged,
          ),
        ],
      ),
    );
  }
}




