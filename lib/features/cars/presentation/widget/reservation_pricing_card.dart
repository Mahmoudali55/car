import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/price_row_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationPricingCard extends StatefulWidget {
  final double totalPrice;
  final double depositAmount;

  const ReservationPricingCard({super.key, required this.totalPrice, required this.depositAmount});

  @override
  State<ReservationPricingCard> createState() => _ReservationPricingCardState();
}

class _ReservationPricingCardState extends State<ReservationPricingCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: (0.03)),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                PriceRowWidget(
                  label: AppLocaleKey.totalAmount.tr(),
                  value: "${widget.totalPrice.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}",
                  isBold: true,
                ),
                Gap(16.h),
                Container(height: 1, color: AppColor.borderColor(context).withValues(alpha: (0.5))),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocaleKey.carDeposit.tr(),
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          AppLocaleKey.refundable.tr(),
                          style: TextStyle(
                            color: const Color(0xFF2E7D32),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${widget.depositAmount.toInt()} ${AppLocaleKey.sar.tr()}",
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2E7D32),
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Column(
                children: [
                  Gap(8.h),
                  PriceRowWidget(
                    label: AppLocaleKey.carPriceWithTax.tr(),
                    value: "${(widget.totalPrice - 0).toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}",
                  ),
                  Gap(8.h),
                  PriceRowWidget(
                    label: AppLocaleKey.platesAndRegistrationFees.tr(),
                    value: "0 ${AppLocaleKey.sar.tr()}",
                  ),
                  Gap(12.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      AppLocaleKey.depositDeductionMessage.tr().replaceAll(
                        '{amount}',
                        widget.depositAmount.toInt().toString(),
                      ),
                      style: AppTextStyle.bodySmall(context).copyWith(
                        fontSize: 10.sp,
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isExpanded ? AppLocaleKey.hideDetails.tr() : AppLocaleKey.showDetails.tr(),
                    style: TextStyle(
                      color: AppColor.primaryColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                  Gap(4.w),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColor.primaryColor(context),
                    size: 18.sp,
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
