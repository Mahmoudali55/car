import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InstallmentRow extends StatelessWidget {
  final int index;
  final int totalMonths;
  final double amount;
  final double residualAmount;
  final DateTime dueDate;

  const InstallmentRow({
    super.key,
    required this.index,
    required this.totalMonths,
    required this.amount,
    required this.residualAmount,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = index == totalMonths - 1;
    final primary = AppColor.primaryColor(context);
    final formatter = NumberFormat('#,##0', 'en_US');
    final dateStr =
        '${dueDate.day.toString().padLeft(2, '0')} / '
        '${dueDate.month.toString().padLeft(2, '0')} / '
        '${dueDate.year}';

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isLast
              ? primary.withValues(alpha: 0.05)
              : AppColor.whiteColor(context).withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isLast
                ? primary.withValues(alpha: 0.3)
                : AppColor.whiteColor(context).withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            // Number badge
            Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                color: isLast
                    ? primary
                    : AppColor.whiteColor(context).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: isLast
                        ? AppColor.whiteColor(context)
                        : AppColor.whiteColor(context).withValues(alpha: 0.6),
                    fontWeight: FontWeight.w900,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Gap(16.w),
            // Label + Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLast
                        ? AppLocaleKey.lastPaymentResidual.tr().toUpperCase()
                        : '${AppLocaleKey.installmentNumber.tr().toUpperCase()} ${index + 1}',
                    style: AppTextStyle.bodySmall(context).copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 11.sp,
                      color: isLast
                          ? AppColor.whiteColor(context)
                          : AppColor.whiteColor(context).withValues(alpha: 0.85),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Gap(3.h),
                  Text(
                    dateStr,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: isLast
                          ? AppColor.whiteColor(context).withValues(alpha: 0.6)
                          : AppColor.greyColor(context),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              '${formatter.format(isLast ? residualAmount : amount)} ${AppLocaleKey.sar.tr().toUpperCase()}',
              style: AppTextStyle.bodyMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                color: AppColor.whiteColor(context),
                fontSize: 13.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
