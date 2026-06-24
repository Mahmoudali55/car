import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/total_row_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TotalBanner extends StatelessWidget {
  final num price;
  final num taxAmount;
  final num platePrice;
  final num total;

  final BuildContext context;

  const TotalBanner({
    super.key,
    required this.price,
    required this.taxAmount,
    required this.platePrice,
    required this.total,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final primary = AppColor.primaryColor(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary.withValues(alpha: 0.12), primary.withValues(alpha: 0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          // تفاصيل البنود
          TotalRow(
            label: AppLocaleKey.agentSellingPrice.tr(),
            value: price,
            context: context,
            color: AppColor.blackTextColor(context),
          ),
          Gap(6.h),
          TotalRow(
            label: AppLocaleKey.tax.tr(),
            value: taxAmount,
            context: context,
            color: AppColor.orangeColor(context),
          ),
          Gap(6.h),
          TotalRow(
            label: AppLocaleKey.plates.tr(),
            value: platePrice,
            context: context,
            color: AppColor.greyColor(context),
          ),
          Gap(10.h),
          Divider(color: primary.withValues(alpha: 0.2), height: 1),
          Gap(10.h),
          // الإجمالي الكلي
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calculate_rounded, color: primary, size: 20.sp),
                  Gap(8.w),
                  Text(
                    AppLocaleKey.total.tr(),
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: primary, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(
                '${NumberFormat('#,##0.##').format(total)} ${AppLocaleKey.sar.tr()}',
                style: AppTextStyle.titleLarge(
                  context,
                ).copyWith(color: primary, fontWeight: FontWeight.w900, fontSize: 22.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Row مساعد داخل البانر
