import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:car/features/services/presentation/widgets/shared/elite_info_tile.dart';
import 'package:car/features/services/presentation/widgets/shared/elite_input_field.dart';
import 'package:car/features/services/presentation/widgets/shared/elite_selection_group.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardStep extends StatelessWidget {
  final BankOffer previewBank;
  final double carPrice;
  final double downPaymentAmount;
  final double lastPaymentAmount;
  final int durationYears;
  final int selectedYear;
  final String selectedBrand;
  final String selectedModel;
  
  final TextEditingController priceController;
  final TextEditingController downPaymentController;
  final TextEditingController lastPaymentController;
  final void Function(int) onDurationChanged;

  const DashboardStep({
    super.key,
    required this.previewBank,
    required this.carPrice,
    required this.downPaymentAmount,
    required this.lastPaymentAmount,
    required this.durationYears,
    required this.selectedYear,
    required this.selectedBrand,
    required this.selectedModel,
    required this.priceController,
    required this.downPaymentController,
    required this.lastPaymentController,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0', 'en_US');
    final calc = previewBank.calculate(
      carPrice: carPrice,
      downPaymentAmount: downPaymentAmount,
      lastPaymentAmount: lastPaymentAmount,
      durationYears: durationYears,
      year: selectedYear,
      brand: selectedBrand,
      model: selectedModel,
    );

    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          // Monthly installment card
          Container(
            padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(color: AppColor.borderColor(context)),
            ),
            child: Column(
              children: [
                Text(
                  AppLocaleKey.monthlyInstallment.tr().toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.greyColor(context),
                    letterSpacing: 4,
                    fontWeight: FontWeight.w900,
                    fontSize: 10.sp,
                  ),
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      formatter.format(calc['monthlyInstallment']),
                      style: AppTextStyle.titleLarge(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 48.sp,
                        letterSpacing: -1,
                      ),
                    ),
                    Gap(8.w),
                    Text(
                      AppLocaleKey.sar.tr().toUpperCase(),
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.blackTextColor(context).withOpacity(0.4),
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                Gap(40.h),
                Container(height: 1, color: AppColor.borderColor(context)),
                Gap(32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EliteInfoTile(
                      label: AppLocaleKey.totalAmount.tr(),
                      value: '${formatter.format(calc['totalAmount'])} SAR',
                    ),
                    EliteInfoTile(
                      label: AppLocaleKey.residual.tr().toUpperCase(),
                      value: '${formatter.format(calc['lastPaymentAmount'])} SAR',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(48.h),
          EliteInputField(
            label: AppLocaleKey.approxCarValue.tr().toUpperCase(),
            controller: priceController,
            suffix: 'SAR',
            hint: '0',
          ),
          Gap(32.h),
          EliteInputField(
            label: AppLocaleKey.availableDownPayment.tr().toUpperCase(),
            controller: downPaymentController,
            suffix: 'SAR',
            hint: '0',
          ),
          Gap(32.h),
          EliteInputField(
            label: AppLocaleKey.lastPaymentResidual.tr().toUpperCase(),
            controller: lastPaymentController,
            suffix: 'SAR',
            hint: '0',
          ),
          Gap(32.h),
          EliteSelectionGroup(
            label: AppLocaleKey.financingDurationYears.tr().toUpperCase(),
            options: const [1, 2, 3, 4, 5],
            selectedValue: durationYears,
            onSelected: onDurationChanged,
            suffix: AppLocaleKey.years.tr().toUpperCase(),
          ),
        ],
      ),
    );
  }
}
