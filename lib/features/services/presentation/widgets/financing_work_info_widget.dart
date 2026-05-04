import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/calculator_banner.dart';
import 'package:car/features/services/presentation/widgets/employment_type_butto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingWorkInfoTab extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onShowCalculator;

  const FinancingWorkInfoTab({super.key, required this.formKey, required this.onShowCalculator});

  @override
  State<FinancingWorkInfoTab> createState() => _FinancingWorkInfoTabState();
}

class _FinancingWorkInfoTabState extends State<FinancingWorkInfoTab> {
  final _employerCtrl = TextEditingController();
  final _jobTitleCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();

  String? _employmentType;

  @override
  void dispose() {
    _employerCtrl.dispose();
    _jobTitleCtrl.dispose();
    _salaryCtrl.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocaleKey.agentEmploymentType.tr(),
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w700, color: AppColor.blackTextColor(context)),
              ),
            ),
            Gap(10.h),
            Row(
              children: [
                Expanded(
                  child: EmploymentTypeButton(
                    value: 'private',
                    label: AppLocaleKey.agentPrivateSector.tr(),
                    selectedType: _employmentType,
                    onTap: (v) => setState(() => _employmentType = v),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: EmploymentTypeButton(
                    value: 'government',
                    label: AppLocaleKey.agentGovSector.tr(),
                    selectedType: _employmentType,
                    onTap: (v) => setState(() => _employmentType = v),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: EmploymentTypeButton(
                    value: 'self',
                    label: AppLocaleKey.agentFreelance.tr(),
                    selectedType: _employmentType,
                    onTap: (v) => setState(() => _employmentType = v),
                  ),
                ),
              ],
            ),
            Gap(20.h),
            CustomFormField(
              controller: _employerCtrl,
              hintText: AppLocaleKey.agentEmployer.tr(),
              radius: 12,
              validator: (v) =>
                  (v == null || v.isEmpty) ? AppLocaleKey.agentEmployerRequired.tr() : null,
            ),
            Gap(16.h),
            CustomFormField(
              controller: _jobTitleCtrl,
              hintText: AppLocaleKey.agentJobTitle.tr(),
              radius: 12,
              validator: (v) =>
                  (v == null || v.isEmpty) ? AppLocaleKey.agentJobTitleRequired.tr() : null,
            ),
            Gap(16.h),
            CustomFormField(
              controller: _salaryCtrl,
              hintText: AppLocaleKey.agentMonthlySalary.tr(),
              radius: 12,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) =>
                  (v == null || v.isEmpty) ? AppLocaleKey.agentSalaryRequired.tr() : null,
            ),
            Gap(20.h),
            CalculatorBanner(onTap: widget.onShowCalculator),
            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
