import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartSummaryWidget extends StatelessWidget {
  final double totalPrice;

  const CartSummaryWidget({super.key, required this.totalPrice});

  String _formatTotalPrice() {
    return totalPrice
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrice = _formatTotalPrice();

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 28.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        border: Border(
          top: BorderSide(
            color: AppColor.borderColor(context).withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.total.tr(),
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(2.h),
                    ValueWithCurrencyIcon(
                      text: '$formattedPrice ${AppLocaleKey.sar.tr()}',
                      textStyle: AppTextStyle.titleLarge(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 22.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        size: 14.sp,
                        color: AppColor.primaryColor(context),
                      ),
                      Gap(4.w),
                      Text(
                        'دفع آمن',
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(16.h),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.paymentScreen, arguments: totalPrice);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                  shadowColor: AppColor.primaryColor(context).withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment_rounded,
                      color: AppColor.whiteColor(context),
                      size: 20.sp,
                    ),
                    Gap(10.w),
                    Text(
                      AppLocaleKey.payNow.tr(),
                      style: AppTextStyle.titleMedium(context).copyWith(
                        color: AppColor.whiteColor(context),
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
