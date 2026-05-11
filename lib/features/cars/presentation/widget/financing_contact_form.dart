import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingContactForm extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final ValueNotifier<bool> whatsappNotifier;
  final ValueNotifier<String?> selectedCityNotifier;

  const FinancingContactForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.whatsappNotifier,
    required this.selectedCityNotifier,
  });

  @override
  State<FinancingContactForm> createState() => _FinancingContactFormState();
}

class _FinancingContactFormState extends State<FinancingContactForm> {
  final List<String> _cities = [
    AppLocaleKey.riyadh.tr(),
    AppLocaleKey.jeddah.tr(),
    AppLocaleKey.makkah.tr(),
    AppLocaleKey.madinah.tr(),
    AppLocaleKey.dammam.tr(),
    AppLocaleKey.khobar.tr(),
    AppLocaleKey.dhahran.tr(),
    AppLocaleKey.abha.tr(),
    AppLocaleKey.tabuk.tr(),
    AppLocaleKey.buraidah.tr(),
    AppLocaleKey.hail.tr(),
    AppLocaleKey.najran.tr(),
    AppLocaleKey.jazan.tr(),
    AppLocaleKey.taif.tr(),
    AppLocaleKey.jubail.tr(),
  ];

  final _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          controller: widget.firstNameController,
          hintText: AppLocaleKey.firstName.tr(),
          radius: _borderRadius,
          validator: (v) => (v == null || v.isEmpty) ? AppLocaleKey.firstNameRequired.tr() : null,
        ),
        Gap(16.h),
        CustomFormField(
          controller: widget.lastNameController,
          hintText: AppLocaleKey.lastName.tr(),
          radius: _borderRadius,
          validator: (v) => (v == null || v.isEmpty) ? AppLocaleKey.lastNameRequired.tr() : null,
        ),
        Gap(16.h),
        CustomFormField(
          controller: widget.phoneController,
          hintText: AppLocaleKey.phoneNumber.tr(),
          radius: _borderRadius,
          keyboardType: TextInputType.phone,
          validator: (v) => (v == null || v.isEmpty) ? AppLocaleKey.phoneNumberRequired.tr() : null,
        ),
        Gap(16.h),
        ValueListenableBuilder<bool>(
          valueListenable: widget.whatsappNotifier,
          builder: (context, val, _) {
            return GestureDetector(
              onTap: () => widget.whatsappNotifier.value = !val,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: const Color(0xff25D366), size: 20.sp),
                        Gap(8.w),
                        Text(
                          AppLocaleKey.whatsappUpdates.tr(),
                          style: AppTextStyle.bodySmall(context).copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackTextColor(context).withValues(alpha: (0.7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(12.w),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: val ? AppColor.primaryColor(context) : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: val ? AppColor.primaryColor(context) : Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: val
                        ? Icon(
                            Icons.check_rounded,
                            color: AppColor.whiteColor(context),
                            size: 14.sp,
                          )
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
        Gap(24.h),
        Text(
          AppLocaleKey.city.tr(),
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
        ),
        Gap(12.h),
        ValueListenableBuilder<String?>(
          valueListenable: widget.selectedCityNotifier,
          builder: (context, selectedCity, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.borderColor(context)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCity,
                  isExpanded: true,
                  hint: Text(
                    AppLocaleKey.selectCity.tr(),
                    style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.grey),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColor.blackTextColor(context),
                  ),
                  items: _cities
                      .map(
                        (city) => DropdownMenuItem(
                          value: city,
                          child: Text(city, style: AppTextStyle.bodyMedium(context)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => widget.selectedCityNotifier.value = v,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
