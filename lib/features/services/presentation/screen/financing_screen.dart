import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankOffer {
  final String nameKey;
  final String logoText;
  final double apr;
  final Color brandColor;

  BankOffer({
    required this.nameKey,
    required this.logoText,
    required this.apr,
    required this.brandColor,
  });

  Map<String, double> calculate(num carPrice, num downPayment, int durationYears) {
    final principal = (carPrice - downPayment).toDouble();
    if (principal <= 0) return {'totalAmount': 0, 'monthlyInstallment': 0};
    final totalProfit = principal * (apr / 100) * durationYears;
    final totalAmount = principal + totalProfit;
    final monthlyInstallment = totalAmount / (durationYears * 12);
    return {'totalAmount': totalAmount, 'monthlyInstallment': monthlyInstallment};
  }
}

class FinancingScreen extends StatefulWidget {
  final Map<String, dynamic>? car;
  const FinancingScreen({super.key, this.car});

  @override
  State<FinancingScreen> createState() => _FinancingScreenState();
}

class _FinancingScreenState extends State<FinancingScreen> {
  int _currentStep = 0;
  late double _carPrice;
  double _downPaymentPercent = 10;
  int _durationYears = 5;
  BankOffer? _selectedBank;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _workController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _workController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  final List<BankOffer> _banks = [
    BankOffer(nameKey: AppLocaleKey.bankAlrajhi, logoText: 'AR', apr: 3.5, brandColor: const Color(0xFF133261)),
    BankOffer(nameKey: AppLocaleKey.bankSnb, logoText: 'SNB', apr: 2.9, brandColor: const Color(0xFF00755F)),
    BankOffer(nameKey: AppLocaleKey.bankRiyad, logoText: 'RB', apr: 3.2, brandColor: const Color(0xFFCE1126)),
    BankOffer(nameKey: AppLocaleKey.bankAlinma, logoText: 'INM', apr: 3.0, brandColor: const Color(0xFF886A34)),
  ];

  @override
  void initState() {
    super.initState();
    _carPrice = double.tryParse(widget.car?['price']?.toString().replaceAll(',', '') ?? '150000') ?? 150000;
  }

  double get _downPaymentAmount => (_carPrice * _downPaymentPercent) / 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Stack(
        children: [
          // Background Gradient Header
          Container(
            height: 220.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.primaryColor(context),
                  const Color(0xff0047BB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                _buildStepIndicator(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: _buildCurrentStepView(),
                    ),
                  ),
                ),
                _buildBottomActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          const Spacer(),
          Text(
            AppLocaleKey.financingSolutions.tr(),
            style: AppTextStyle.titleMedium(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final isActive = _currentStep >= index;
          return Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 36.w,
                  width: 36.w,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    boxShadow: isActive
                        ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10)]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isActive ? AppColor.primaryColor(context) : Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (index < 2)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: _currentStep > index ? Colors.white : Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepView() {
    switch (_currentStep) {
      case 0:
        return _buildCalculatorStep();
      case 1:
        return _buildBankStep();
      case 2:
        return _buildFinalFormStep();
      default:
        return Container();
    }
  }

  Widget _buildCalculatorStep() {
    final formatter = NumberFormat('#,##0', 'en_US');
    final installment = _banks[0].calculate(_carPrice, _downPaymentAmount, _durationYears)['monthlyInstallment']!;

    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Installment Display Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColor.secondAppColor(context),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10))
              ],
            ),
            child: Column(
              children: [
                Text(
                  AppLocaleKey.monthlyInstallment.tr(),
                  style: AppTextStyle.bodySmall(context).copyWith(color: Colors.grey),
                ),
                Gap(8.h),
                Text(
                  '${formatter.format(installment)} ${AppLocaleKey.sar.tr()}',
                  style: AppTextStyle.titleLarge(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 32.sp,
                  ),
                ),
                Gap(16.h),
                const Divider(),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoMini(AppLocaleKey.totalAmount.tr(), '${formatter.format(_carPrice)}'),
                    _buildInfoMini(AppLocaleKey.downPayment.tr(), '${formatter.format(_downPaymentAmount)}'),
                  ],
                ),
              ],
            ),
          ),
          Gap(30.h),
          _buildSlider(AppLocaleKey.approxCarValue.tr(), _carPrice, 50000, 1000000, (val) => setState(() => _carPrice = val), suffix: 'SAR'),
          Gap(24.h),
          _buildSlider(AppLocaleKey.availableDownPayment.tr(), _downPaymentPercent, 0, 90, (val) => setState(() => _downPaymentPercent = val), suffix: '%'),
          Gap(24.h),
          _buildSlider(AppLocaleKey.financingDurationYears.tr(), _durationYears.toDouble(), 1, 5, (val) => setState(() => _durationYears = val.toInt()), suffix: 'Years', divisions: 4),
          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildInfoMini(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
        Gap(4.h),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged, {String suffix = '', int? divisions}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            Text('${value.toStringAsFixed(0)} $suffix', style: TextStyle(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: AppColor.primaryColor(context),
          label: value.toStringAsFixed(0),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildBankStep() {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.viewOffers.tr(),
            style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(16.h),
          ..._banks.map((bank) {
            final isSelected = _selectedBank == bank;
            final calc = bank.calculate(_carPrice, _downPaymentAmount, _durationYears);
            final formatter = NumberFormat('#,##0', 'en_US');

            return GestureDetector(
              onTap: () => setState(() => _selectedBank = bank),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.secondAppColor(context),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? AppColor.primaryColor(context) : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 5))
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: bank.brandColor,
                      radius: 24.r,
                      child: Text(bank.logoText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bank.nameKey.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('${bank.apr}% ${AppLocaleKey.profitMargin.tr()}', style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${formatter.format(calc['monthlyInstallment'])}',
                          style: TextStyle(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        Text('SAR/Mo', style: TextStyle(color: Colors.grey, fontSize: 10.sp)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFinalFormStep() {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocaleKey.personalInfo.tr(), style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold)),
          Gap(16.h),
          CustomFormField(
            hintText: 'Full Name',
            controller: _nameController,
            validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
          ),
          Gap(12.h),
          CustomFormField(
            hintText: 'Phone Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.length < 9 ? AppLocaleKey.validatePhoneNumber.tr() : null,
          ),
          Gap(12.h),
          CustomFormField(
            hintText: AppLocaleKey.nationalId.tr(),
            controller: _idController,
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty ? AppLocaleKey.validateId.tr() : null,
          ),
          Gap(12.h),
          CustomFormField(
            hintText: AppLocaleKey.workPlace.tr(),
            controller: _workController,
            validator: (value) => value == null || value.isEmpty ? AppLocaleKey.validateWork.tr() : null,
          ),
          Gap(12.h),
          CustomFormField(
            hintText: AppLocaleKey.approxMonthlySalary.tr(),
            controller: _salaryController,
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty ? AppLocaleKey.validateSalary.tr() : null,
          ),
          Gap(30.h),
          // Selected Bank Summary
          if (_selectedBank != null)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: _selectedBank!.brandColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: _selectedBank!.brandColor.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_rounded, color: _selectedBank!.brandColor),
                  Gap(12.w),
                  Text(_selectedBank!.nameKey.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: _selectedBank!.brandColor)),
                  const Spacer(),
                  const Icon(Icons.check_circle_rounded, color: Colors.green),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                child: Text(AppLocaleKey.cancel.tr()),
              ),
            ),
          if (_currentStep > 0) Gap(16.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 2) {
                  if (_currentStep == 1 && _selectedBank == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a bank')));
                    return;
                  }
                  setState(() => _currentStep++);
                } else {
                  if (_formKey.currentState!.validate()) {
                    _showSuccessDialog();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor(context),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              ),
              child: Text(
                _currentStep == 2 ? AppLocaleKey.submitFinancingRequest.tr() : AppLocaleKey.next.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.secondAppColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(20.h),
            Icon(Icons.check_circle_rounded, color: Colors.green, size: 80.sp),
            Gap(20.h),
            Text(
              AppLocaleKey.requestSubmittedSuccess.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(10.h),
            Text(
              AppLocaleKey.teamWillContactSoon.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
            Gap(30.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(context),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(AppLocaleKey.ok.tr(), style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
