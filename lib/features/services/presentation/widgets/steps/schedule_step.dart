import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:car/features/services/presentation/widgets/shared/installment_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ScheduleStep extends StatefulWidget {
  final BankOffer selectedBank;
  final double carPrice;
  final double downPaymentAmount;
  final double lastPaymentAmount;
  final int durationYears;
  final int selectedYear;
  final String selectedBrand;
  final String selectedModel;

  const ScheduleStep({
    super.key,
    required this.selectedBank,
    required this.carPrice,
    required this.downPaymentAmount,
    required this.lastPaymentAmount,
    required this.durationYears,
    required this.selectedYear,
    required this.selectedBrand,
    required this.selectedModel,
  });

  @override
  State<ScheduleStep> createState() => _ScheduleStepState();
}

class _ScheduleStepState extends State<ScheduleStep> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final calc = widget.selectedBank.calculate(
      carPrice: widget.carPrice,
      downPaymentAmount: widget.downPaymentAmount,
      lastPaymentAmount: widget.lastPaymentAmount,
      durationYears: widget.durationYears,
      year: widget.selectedYear,
      brand: widget.selectedBrand,
      model: widget.selectedModel,
    );
    final monthly = calc['monthlyInstallment']!;
    final residual = calc['lastPaymentAmount']!;
    final totalMonths = widget.durationYears * 12;
    final primary = AppColor.primaryColor(context);
    final now = DateTime.now();
    final displayCount = _showAll ? totalMonths : 4;

    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                AppLocaleKey.installmentSchedule.tr().toUpperCase(),
                style: AppTextStyle.titleMedium(context).copyWith(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColor.blackTextColor(context).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColor.borderColor(context)),
                ),
                child: Text(
                  AppLocaleKey.titaniumPlan.tr().toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.blackTextColor(context).withOpacity(0.7),
                    fontWeight: FontWeight.w900,
                    fontSize: 8.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          Gap(16.h),

          // Count badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: primary.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_month_rounded, color: primary, size: 16.sp),
                Gap(8.w),
                Text(
                  '$totalMonths ${AppLocaleKey.installmentSchedule.tr()}',
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Gap(24.h),

          // Installment rows
          ...List.generate(displayCount, (i) => InstallmentRow(
                index: i,
                totalMonths: totalMonths,
                amount: monthly,
                residualAmount: residual,
                dueDate: DateTime(now.year, now.month + i + 1),
              )),

          // Show more / less
          if (totalMonths > 4)
            GestureDetector(
              onTap: () => setState(() => _showAll = !_showAll),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColor.blackTextColor(context).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColor.borderColor(context)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _showAll ? AppLocaleKey.showLess.tr() : AppLocaleKey.showMore.tr(),
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Gap(6.w),
                    Icon(
                      _showAll
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: primary,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ),
          Gap(8.h),
        ],
      ),
    );
  }
}
