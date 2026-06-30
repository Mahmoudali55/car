import 'dart:io';

import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moyasar/moyasar.dart';

class ReservationPaymentBody extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final double totalPrice;
  final double depositAmount;
  final bool isLoading;
  final void Function(dynamic result, {required bool isApplePay}) onPaymentResult;

  const ReservationPaymentBody({
    super.key,
    required this.car,
    required this.totalPrice,
    required this.depositAmount,
    required this.isLoading,
    required this.onPaymentResult,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final paymentConfig = PaymentConfig(
      publishableApiKey: Constants.moyasarPublishableKey,
      amount: (depositAmount * 100).toInt(),
      description: isArabic ? 'حجز سيارة ${car.itemName}' : 'Car Reservation - ${car.itemName}',
      metadata: {'item_code': car.itemCode, 'chassis_no': car.chassisNo},
      creditCard: CreditCardConfig(saveCard: false, manual: false),
      applePay: ApplePayConfig(
        merchantId: Constants.applePayMerchantId,
        label: isArabic ? 'شركة معرض السيارات' : 'Car Dealership App',
        manual: false,
        saveCard: false,
      ),
      supportedNetworks: const [
        PaymentNetwork.mada,
        PaymentNetwork.visa,
        PaymentNetwork.masterCard,
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PaymentStepIndicator(),
        Gap(24.h),
        _CarSummaryCard(car: car, totalPrice: totalPrice),
        Gap(24.h),
        _DepositBanner(depositAmount: depositAmount, isArabic: isArabic),
        Gap(24.h),
        if (isLoading)
          _LoadingIndicator(isArabic: isArabic)
        else ...[
          if (Platform.isIOS) ...[
            ApplePay(
              config: paymentConfig,
              onPaymentResult: (r) => onPaymentResult(r, isApplePay: true),
            ),
            Gap(16.h),
            _OrDivider(isArabic: isArabic),
            Gap(16.h),
          ],
          Theme(
            data: Theme.of(context).copyWith(
              // Ensure text colors inside Moyasar inputs match theme text colors
              textTheme: Theme.of(context).textTheme.copyWith(
                titleMedium: TextStyle(color: AppColor.blackColor(context)),
                bodyMedium: TextStyle(color: AppColor.blackColor(context)),
                bodyLarge: TextStyle(color: AppColor.blackColor(context)),
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: AppColor.blackColor(context)),
                hintStyle: TextStyle(color: AppColor.hintColor(context)),
                counterStyle: TextStyle(color: AppColor.blackColor(context)),
                suffixStyle: TextStyle(color: AppColor.blackColor(context)),
                prefixStyle: TextStyle(color: AppColor.blackColor(context)),
              ),
              hintColor: AppColor.hintColor(context),
            ),
            child: CreditCard(
              config: paymentConfig,
              onPaymentResult: (r) => onPaymentResult(r, isApplePay: false),
            ),
          ),
        ],
        Gap(24.h),
        _GuaranteeBanner(),
        Gap(60.h),
      ],
    );
  }
}

class _PaymentStepIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepTab(label: AppLocaleKey.payment.tr(), color: const Color(0xFF0D47A1)),
        _StepTab(label: AppLocaleKey.addInfo.tr(), color: const Color(0xFF2E7D32)),
      ],
    );
  }
}

class _StepTab extends StatelessWidget {
  final String label;
  final Color color;
  const _StepTab({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          Gap(8.h),
          Container(
            height: 3.h,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.r)),
          ),
        ],
      ),
    );
  }
}

class _CarSummaryCard extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final double totalPrice;
  const _CarSummaryCard({required this.car, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF0D47A1), size: 24.sp),
              Gap(8.w),
              ValueWithCurrencyIcon(
                text: '${totalPrice.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}',
                textStyle: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: const Color(0xFF0D47A1), fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Gap(12.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        car.itemName,
                        style: AppTextStyle.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        car.makeYear.toString(),
                        style: TextStyle(color: AppColor.greyColor(context), fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                Gap(12.w),
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.scaffoldColor(context),
                    border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.5)),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: _BrandLogo(car: car),
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

class _BrandLogo extends StatelessWidget {
  final GetBrandCarsDataModel car;
  const _BrandLogo({required this.car});

  @override
  Widget build(BuildContext context) {
    final brandName = car.groupName.toLowerCase();
    String? logoPath;
    for (final b in BrandModel.brands) {
      if (b.name.toLowerCase() == brandName && b.logo.isNotEmpty) {
        logoPath = b.logo;
        break;
      }
    }
    if (logoPath != null && logoPath.isNotEmpty) {
      return Image.asset(
        logoPath,
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Icon(
          Icons.directions_car_filled_rounded,
          color: AppColor.primaryColor(context),
          size: 20.sp,
        ),
      );
    }
    return Icon(
      Icons.directions_car_filled_rounded,
      color: AppColor.primaryColor(context),
      size: 20.sp,
    );
  }
}

class _DepositBanner extends StatelessWidget {
  final double depositAmount;
  final bool isArabic;
  const _DepositBanner({required this.depositAmount, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor(context),
            AppColor.primaryColor(context).withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline_rounded, color: AppColor.whiteColor(context), size: 20.sp),
          Gap(10.w),
          ValueWithCurrencyIcon(
            text: isArabic
                ? 'مبلغ العربون: ${depositAmount.toInt()} ${AppLocaleKey.sar.tr()}'
                : 'Deposit Amount: ${depositAmount.toInt()} SAR',
            textStyle: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  final bool isArabic;
  const _LoadingIndicator({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            CircularProgressIndicator(color: AppColor.primaryColor(context)),
            Gap(16.h),
            Text(
              isArabic ? 'جارٍ معالجة الدفع...' : 'Processing payment...',
              style: AppTextStyle.bodyMedium(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  final bool isArabic;
  const _OrDivider({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            isArabic ? 'أو الدفع باستخدام البطاقة' : 'Or pay with credit card',
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _GuaranteeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFC8E6C9)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user_rounded, color: const Color(0xFF2E7D32), size: 24.sp),
          Gap(12.w),
          Expanded(
            child: Text(
              AppLocaleKey.about.tr(),
              style: AppTextStyle.bodySmall(
                context,
              ).copyWith(color: const Color(0xFF2E7D32), fontWeight: FontWeight.w600, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
