import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/car_summary_card.dart';
import 'package:car/features/services/presentation/widgets/city_dropdown.dart';
import 'package:car/features/services/presentation/widgets/gender_button.dart';
import 'package:car/features/services/presentation/widgets/info_banner.dart';
import 'package:car/features/services/presentation/widgets/whats_app_consent_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingPersonalInfoTab extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic>? car;
  final double monthlyInstallment;
  final int durationYears;
  final double downPayment;
  final double lastPayment;
  final VoidCallback onEditCalculator;
  final VoidCallback onShowRequirements;
  final String? bankName;
  final ValueChanged<String>? onPhoneChanged;
  const FinancingPersonalInfoTab({
    super.key,
    required this.formKey,
    required this.car,
    required this.monthlyInstallment,
    required this.durationYears,
    required this.downPayment,
    required this.lastPayment,
    required this.onEditCalculator,
    required this.onShowRequirements,
    this.bankName,
    this.onPhoneChanged,
  });

  @override
  State<FinancingPersonalInfoTab> createState() => _FinancingPersonalInfoTabState();
}

class _FinancingPersonalInfoTabState extends State<FinancingPersonalInfoTab> {
  final _fullNameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  bool _whatsappConsent = true;
  String? _selectedGender;
  String? _selectedCity;
  final name = HiveMethods.getname();
  final phone = HiveMethods.getphone();
  @override
  void initState() {
    super.initState();
    _selectedCity = AppLocaleKey.cityRiyadh.tr();
    _fullNameCtrl.text = name.toString();
    _phoneCtrl.text = phone ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPhoneChanged?.call(_phoneCtrl.text);
    });
    _phoneCtrl.addListener(() {
      widget.onPhoneChanged?.call(_phoneCtrl.text);
    });
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _idCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarSummaryCard(
              car: widget.car,
              bankName: widget.bankName,
              monthlyInstallment: widget.monthlyInstallment,
              durationYears: widget.durationYears,
              downPayment: widget.downPayment,
              lastPayment: widget.lastPayment,
              onEdit: widget.onEditCalculator,
            ),
            Gap(20.h),
            Text(
              AppLocaleKey.agentEnterDetails.tr(),
              style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w700),
            ),
            Gap(10.h),
            CustomFormField(
              controller: _fullNameCtrl,
              hintText: AppLocaleKey.agentFullName.tr(),
              radius: 12,
              validator: (v) => (v == null || v.isEmpty) ? AppLocaleKey.agentFullName.tr() : null,
            ),
            Gap(20.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocaleKey.agentGender.tr(),
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w700, color: AppColor.blackTextColor(context)),
              ),
            ),
            Gap(10.h),
            Row(
              children: [
                Expanded(
                  child: GenderButton(
                    value: 'female',
                    label: AppLocaleKey.agentFemale.tr(),
                    selectedGender: _selectedGender,
                    onTap: (v) => setState(() => _selectedGender = v),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: GenderButton(
                    value: 'male',
                    label: AppLocaleKey.agentMale.tr(),
                    selectedGender: _selectedGender,
                    onTap: (v) => setState(() => _selectedGender = v),
                  ),
                ),
              ],
            ),
            Gap(20.h),
            CustomFormField(
              controller: _idCtrl,
              hintText: AppLocaleKey.agentNationalId.tr(),
              radius: 12,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return AppLocaleKey.agentNationalIdRequired.tr();
                }
                if (v.length != 10) return AppLocaleKey.validateIdLength.tr();
                if (!v.startsWith('2')) return AppLocaleKey.validateIdStart.tr();
                return null;
              },
            ),
            Gap(16.h),
            CustomFormField(
              controller: _phoneCtrl,
              hintText: AppLocaleKey.agentPhones.tr(),
              radius: 12,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return AppLocaleKey.agentPhonesRequired.tr();
                }
                if (v.length != 10) {
                  return AppLocaleKey.validatePhoneLength.tr();
                }
                if (!v.startsWith('05')) {
                  return AppLocaleKey.validatePhoneStart.tr();
                }
                return null;
              },
            ),
            Gap(16.h),
            const WhatsAppConsentWidget(),
            Gap(20.h),
            CityDropdown(
              selectedCity: _selectedCity,
              onChanged: (city) => setState(() => _selectedCity = city),
            ),
            Gap(20.h),
            InfoBanner(onTap: widget.onShowRequirements),
            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
