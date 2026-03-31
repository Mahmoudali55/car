import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardPreviewWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiry;

  const PaymentCardPreviewWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.primaryColor(context), AppColor.primaryColor(context).withOpacity(0.6)],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor(context).withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VISA',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
              ),
              Icon(
                Icons.wifi_rounded,
                color: AppColor.blackTextColor(context).withOpacity(0.8),
                size: 24.sp,
              ),
            ],
          ),
          Text(
            cardNumber,
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PreviewColumn(
                title: AppLocaleKey.paymentCardPreviewHolderTitle.tr(),
                value: cardHolder,
              ),
              _PreviewColumn(
                title: AppLocaleKey.paymentCardPreviewExpiryTitle.tr(),
                value: expiry,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewColumn extends StatelessWidget {
  final String title;
  final String value;

  const _PreviewColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.blackTextColor(context).withOpacity(0.6),
            fontSize: 9.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
