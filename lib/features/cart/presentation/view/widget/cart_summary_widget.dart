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

  String _formatTotalPrice(BuildContext context) {
    // Matches the existing formatting approach from the original screen.
    final formatted = totalPrice
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    return '$formatted ${AppLocaleKey.sar.tr()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        border: Border(top: BorderSide(color: AppColor.blackTextColor(context).withOpacity(0.06))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocaleKey.total.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.7)),
              ),
              Text(
                _formatTotalPrice(context),
                style: AppTextStyle.titleLarge(context).copyWith(
                  color: AppColor.primaryColor(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
          Gap(16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.paymentScreen, arguments: totalPrice);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor(context),
                padding: EdgeInsets.symmetric(vertical: 18.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment_rounded, color: AppColor.whiteColor(context), size: 22.sp),
                  Gap(10.w),
                  Text(
                    AppLocaleKey.payNow.tr(),
                    style: AppTextStyle.titleMedium(
                      context,
                    ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
