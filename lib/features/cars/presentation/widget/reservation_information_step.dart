import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/financing_contact_form.dart';
import 'package:car/features/cars/presentation/widget/reservation_pricing_card.dart';
import 'package:car/features/cars/presentation/widget/reservation_step_indicator.dart';
import 'package:car/features/cars/presentation/widget/reservation_trust_badge.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationInformationStep extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final bool isFinancingFlow;
  final double totalPrice;
  final double depositAmount;
  final GlobalKey<FormState> formKey;
  final TextEditingController cashNameController;
  final TextEditingController cashPhoneController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController financePhoneController;
  final ValueNotifier<bool> whatsappNotifier;
  final ValueNotifier<String?> selectedCityNotifier;
  final VoidCallback onShowPricingDetails;

  const ReservationInformationStep({
    super.key,
    required this.car,
    required this.isFinancingFlow,
    required this.totalPrice,
    required this.depositAmount,
    required this.formKey,
    required this.cashNameController,
    required this.cashPhoneController,
    required this.firstNameController,
    required this.lastNameController,
    required this.financePhoneController,
    required this.whatsappNotifier,
    required this.selectedCityNotifier,
    required this.onShowPricingDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReservationStepIndicator(currentStep: 0, isFinancingFlow: isFinancingFlow),
        Gap(8.h),
        if (isFinancingFlow)
          _FinancingPricingCard(totalPrice: totalPrice, onShowDetails: onShowPricingDetails)
        else
          ReservationPricingCard(totalPrice: totalPrice, depositAmount: depositAmount),
        Gap(32.h),
        Text(
          isFinancingFlow
              ? AppLocaleKey.agentEnterDetails.tr()
              : AppLocaleKey.agentContactInfo.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: 20.sp),
        ),
        Gap(16.h),
        if (isFinancingFlow)
          FinancingContactForm(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            phoneController: financePhoneController,
            whatsappNotifier: whatsappNotifier,
            selectedCityNotifier: selectedCityNotifier,
          )
        else ...[
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: cashNameController,
                  hintText: AppLocaleKey.agentFullName.tr(),
                  radius: 12,
                  validator: (v) => v == null || v.isEmpty ? AppLocaleKey.validateEmpty.tr() : null,
                ),
                Gap(16.h),
                CustomFormField(
                  controller: cashPhoneController,
                  hintText: AppLocaleKey.agentPhone.tr(),
                  radius: 12,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return AppLocaleKey.validateEmpty.tr();
                    }
                    if (!v.startsWith('05')) {
                      return context.locale.languageCode == 'ar'
                          ? 'رقم الجوال يجب أن يبدأ بـ 05'
                          : 'Phone number must start with 05';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                      return context.locale.languageCode == 'ar'
                          ? 'رقم الجوال يجب أن يحتوي على أرقام فقط'
                          : 'Phone number must contain only digits';
                    } else if (v.length < 10) {
                      return context.locale.languageCode == 'ar'
                          ? 'رقم الجوال يجب أن يكون 10 أرقام'
                          : 'Phone number must be 10 digits';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Gap(32.h),
          const ReservationTrustBadge(),
        ],
      ],
    );
  }
}

class _FinancingPricingCard extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onShowDetails;

  const _FinancingPricingCard({required this.totalPrice, required this.onShowDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocaleKey.agentTotalPrice.tr(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 18.sp,
                      color: AppColor.blackTextColor(context),
                    ),
                    Gap(6.w),
                    ValueWithCurrencyIcon(
                      text: '${totalPrice.toStringAsFixed(2)} SAR',
                      textStyle: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onShowDetails,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2F7),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
              ),
              child: Center(
                child: Text(
                  AppLocaleKey.agentShowDetails.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
