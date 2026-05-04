import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/car_summary_card.dart';
import 'package:car/features/services/presentation/widgets/city_dropdown.dart';
import 'package:car/features/services/presentation/widgets/gender_button.dart';
import 'package:car/features/services/presentation/widgets/info_banner.dart';
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
  });

  @override
  State<FinancingPersonalInfoTab> createState() =>
      _FinancingPersonalInfoTabState();
}

class _FinancingPersonalInfoTabState extends State<FinancingPersonalInfoTab> {
  final _fullNameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  bool _whatsappConsent = true;
  String? _selectedGender;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = AppLocaleKey.cityRiyadh.tr();
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
              monthlyInstallment: widget.monthlyInstallment,
              durationYears: widget.durationYears,
              downPayment: widget.downPayment,
              lastPayment: widget.lastPayment,
              onEdit: widget.onEditCalculator,
            ),
            Gap(20.h),
            Text(
              AppLocaleKey.agentEnterDetails.tr(),
              style: AppTextStyle.bodyMedium(context)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Gap(10.h),
            CustomFormField(
              controller: _fullNameCtrl,
              hintText: AppLocaleKey.agentFullName.tr(),
              radius: 12,
              validator: (v) =>
                  (v == null || v.isEmpty)
                      ? AppLocaleKey.agentFullName.tr()
                      : null,
            ),
            Gap(20.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocaleKey.agentGender.tr(),
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.blackTextColor(context),
                ),
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
            _buildWhatsAppConsent(context),
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

  Widget _buildWhatsAppConsent(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _whatsappConsent = !_whatsappConsent),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: _whatsappConsent
                  ? AppColor.primaryColor(context)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: _whatsappConsent
                    ? AppColor.primaryColor(context)
                    : AppColor.borderColor(context),
                width: 1.5,
              ),
            ),
            child: _whatsappConsent
                ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                : null,
          ),
          Gap(10.w),
          Icon(Icons.phone, color: const Color(0xff25D366), size: 20.sp),
          Gap(6.w),
          Expanded(
            child: Text(
              AppLocaleKey.agentWhatsAppNotification.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                fontSize: 12.sp,
                color: AppColor.blackTextColor(context).withOpacity(0.75),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
