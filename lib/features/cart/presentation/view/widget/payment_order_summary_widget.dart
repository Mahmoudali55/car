import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentOrderSummaryWidget extends StatelessWidget {
  final String carsTotalLabel;
  final String serviceFeeLabel;
  final String totalLabel;
  final String carsTotalValue;
  final String serviceFeeValue;
  final String totalValue;

  const PaymentOrderSummaryWidget({
    super.key,
    required this.carsTotalLabel,
    required this.serviceFeeLabel,
    required this.totalLabel,
    required this.carsTotalValue,
    required this.serviceFeeValue,
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.06)),
      ),
      child: Column(
        children: [
          _SummaryRow(label: carsTotalLabel, value: carsTotalValue),
          Gap(10.h),
          _SummaryRow(label: serviceFeeLabel, value: serviceFeeValue),
          Gap(10.h),
          Divider(color: AppColor.blackTextColor(context).withOpacity(0.1)),
          Gap(10.h),
          _SummaryRow(label: totalLabel, value: totalValue, isTotal: true),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: isTotal
                ? AppColor.blackTextColor(context)
                : AppColor.blackTextColor(context).withOpacity(0.6),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: isTotal ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 16.sp : 14.sp,
          ),
        ),
      ],
    );
  }
}
