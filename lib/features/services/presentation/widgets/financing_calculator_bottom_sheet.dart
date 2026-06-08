import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/custom_monthly_installment_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingCalculatorBottomSheet extends StatefulWidget {
  final double carPrice;
  final double initialDownPayment;
  final double initialLastPayment;
  final int initialDuration;

  const FinancingCalculatorBottomSheet({
    super.key,
    required this.carPrice,
    this.initialDownPayment = 0,
    this.initialLastPayment = 0,
    this.initialDuration = 5,
  });

  @override
  State<FinancingCalculatorBottomSheet> createState() => _FinancingCalculatorBottomSheetState();
}

class _FinancingCalculatorBottomSheetState extends State<FinancingCalculatorBottomSheet> {
  late int _durationYears;
  late double _downPayment;
  late double _lastPayment;
  late TextEditingController _downPaymentCtrl;
  late TextEditingController _lastPaymentCtrl;

  static const double _apr = 4.5;

  @override
  void initState() {
    super.initState();
    _durationYears = widget.initialDuration;
    _downPayment = widget.initialDownPayment;
    _lastPayment = widget.initialLastPayment;
    _downPaymentCtrl = TextEditingController(text: _downPayment.toStringAsFixed(1));
    _lastPaymentCtrl = TextEditingController(text: _lastPayment.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _downPaymentCtrl.dispose();
    _lastPaymentCtrl.dispose();
    super.dispose();
  }

  double get _totalFinancing {
    final financed = widget.carPrice - _downPayment;
    if (financed <= 0) return 0;
    final profit = financed * (_apr / 100) * _durationYears;
    return financed + profit;
  }

  double get _monthlyInstallment {
    final total = _totalFinancing;
    if (total <= 0) return 0;
    return (total - _lastPayment) / (_durationYears * 12);
  }

  double get _maxDownPayment => widget.carPrice * 0.35;
  double get _maxLastPayment => widget.carPrice * 0.45;

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0', 'en_US');
    final monthly = _monthlyInstallment;
    final total = _totalFinancing;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.greyColor(context).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Title row
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColor.borderColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16.sp, color: AppColor.blackTextColor(context)),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      AppLocaleKey.calculatesFinancing.tr(),
                      style: AppTextStyle.titleMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Monthly installment card (blue background)
                  CustomMonthlyInstallmentCardWidget(fmt: fmt, monthly: monthly, total: total),
                  Gap(24.h),
                  // Duration selector
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppLocaleKey.agentYears.tr(),
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.blackTextColor(context),
                      ),
                    ),
                  ),
                  Gap(12.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [5, 4, 3, 2, 1].map((year) {
                      final isSelected = _durationYears == year;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _durationYears = year),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.only(left: year != 1 ? 8.w : 0),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.primaryColor(context)
                                  : AppColor.cardColor(context),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.primaryColor(context)
                                    : AppColor.borderColor(context),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '$year',
                                  style: AppTextStyle.bodyLarge(context).copyWith(
                                    color: isSelected
                                        ? AppColor.whiteColor(context)
                                        : AppColor.blackTextColor(context),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  year == 1
                                      ? 'سنة'
                                      : year == 2
                                      ? 'سنتين'
                                      : 'سنوات',
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: isSelected
                                        ? AppColor.whiteColor(context)
                                        : AppColor.greyColor(context),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Gap(24.h),
                  Column(
                    children: [
                      CustomFormField(
                        title: AppLocaleKey.agentFirstPayment.tr(),
                        controller: _downPaymentCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                        hintText: '0.0',

                        onChanged: (v) {
                          setState(() {
                            _downPayment = double.tryParse(v) ?? 0;
                          });
                        },
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            AppLocaleKey.agentYearly.tr(),
                            style: AppTextStyle.bodyLarge(context).copyWith(
                              color: AppColor.greyColor(context),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(6.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${AppLocaleKey.agentFirstPayment.tr()}:${fmt.format(_maxDownPayment.round())} ﷼',
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.greyColor(context), fontSize: 11.sp),
                    ),
                  ),
                  Gap(20.h),
                  CustomFormField(
                    title: AppLocaleKey.agentLastPayment.tr(),
                    controller: _lastPaymentCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                    hintText: '0.0',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        AppLocaleKey.agentYearly.tr(),
                        style: AppTextStyle.bodyLarge(context).copyWith(
                          color: AppColor.greyColor(context),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    onChanged: (v) {
                      setState(() {
                        _lastPayment = double.tryParse(v) ?? 0;
                      });
                    },
                  ),
                  Gap(6.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${AppLocaleKey.agentLastPaymentDesc.tr()} : ${fmt.format(_maxLastPayment.round())} ﷼',
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.greyColor(context), fontSize: 11.sp),
                    ),
                  ),
                  Gap(24.h),
                  // Fund now button
                  CustomButton(
                    radius: 12.r,
                    color: AppColor.greenColor(context),
                    onPressed: () => Navigator.pop(context, {
                      'duration': _durationYears,
                      'down': _downPayment,
                      'last': _lastPayment,
                    }),

                    child: Text(
                      AppLocaleKey.agentBuyNow.tr(),
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w700, color: AppColor.whiteColor(context)),
                    ),
                  ),
                  Gap(8.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
