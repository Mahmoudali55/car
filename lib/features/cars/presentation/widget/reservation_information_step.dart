import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/financing_contact_form.dart';
import 'package:car/features/cars/presentation/widget/financing_pricing_card_widget.dart';
import 'package:car/features/cars/presentation/widget/reservation_pricing_card.dart';
import 'package:car/features/cars/presentation/widget/reservation_step_indicator.dart';
import 'package:car/features/cars/presentation/widget/reservation_terms_checkbox_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/admin/data/model/representative_model.dart';
import 'package:car/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:car/features/admin/presentation/cubit/admin_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final bool isTermsAccepted;
  final ValueChanged<bool?> onTermsAcceptedChanged;
  final RepresentativeModel? selectedRepresentative;
  final ValueChanged<RepresentativeModel?> onRepresentativeChanged;

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
    required this.isTermsAccepted,
    required this.onTermsAcceptedChanged,
    required this.selectedRepresentative,
    required this.onRepresentativeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReservationStepIndicator(currentStep: 0, isFinancingFlow: isFinancingFlow),
        Gap(8.h),
        if (isFinancingFlow)
          FinancingPricingCard(totalPrice: totalPrice, onShowDetails: onShowPricingDetails)
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
                const SizedBox(height: 16),
                BlocBuilder<AdminCubit, AdminState>(
                  buildWhen: (previous, current) =>
                      previous.searchRepresentativesStatus != current.searchRepresentativesStatus,
                  builder: (context, state) {
                    final status = state.searchRepresentativesStatus;
                    final representatives = status.data ?? const <RepresentativeModel>[];
                    return DropdownButtonFormField<RepresentativeModel>(
                      initialValue: selectedRepresentative,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'المندوب (اختياري)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      hint: Text(status.isLoading ? 'جاري تحميل المناديب...' : 'اختر مندوبًا'),
                      items: representatives
                          .where((representative) => representative.represNo != null)
                          .map(
                            (representative) => DropdownMenuItem<RepresentativeModel>(
                              value: representative,
                              child: Text(
                                representative.represName ??
                                    representative.represNameEng ??
                                    'مندوب ${representative.represNo}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: status.isLoading ? null : onRepresentativeChanged,
                      validator: (value) => null,
                    );
                  },
                ),
              ],
            ),
          ),
          Gap(16.h),
          ReservationTermsCheckboxWidget(value: isTermsAccepted, onChanged: onTermsAcceptedChanged),
        ],
      ],
    );
  }
}
