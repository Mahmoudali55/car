import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/financing_calculator_bottom_sheet.dart';
import 'package:car/features/services/presentation/widgets/financing_otp_bottom_sheet.dart';
import 'package:car/features/services/presentation/widgets/financing_requirements_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingScreen extends StatefulWidget {
  final Map<String, dynamic>? car;
  final double? initialCarPrice;
  final double? initialDownPayment;
  final int? initialDuration;
  final String? bankNameKey;

  const FinancingScreen({
    super.key,
    this.car,
    this.initialCarPrice,
    this.initialDownPayment,
    this.initialDuration,
    this.bankNameKey,
  });

  @override
  State<FinancingScreen> createState() => _FinancingScreenState();
}

class _FinancingScreenState extends State<FinancingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isCalculatorCompleted = false;

  // ── Calculator step ──
  int _durationYears = 5;
  double _downPayment = 0;
  double _lastPayment = 0;
  late TextEditingController _downPaymentCtrl;
  late TextEditingController _lastPaymentCtrl;
  static const double _apr = 4.5;

  // Tab 1 - Personal Info
  final _fullNameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _whatsappConsent = true;
  String? _selectedGender;
  String? _selectedCity;

  // Tab 2 - Work Info
  final _employerCtrl = TextEditingController();
  final _jobTitleCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  String? _employmentType;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  late double _carPrice;

  List<String> get _cities => [
    AppLocaleKey.cityRiyadh.tr(),
    AppLocaleKey.cityJeddah.tr(),
    AppLocaleKey.cityMecca.tr(),
    AppLocaleKey.cityMedina.tr(),
    AppLocaleKey.cityDammam.tr(),
    AppLocaleKey.cityKhobar.tr(),
    AppLocaleKey.cityDhahran.tr(),
    AppLocaleKey.cityAbha.tr(),
    AppLocaleKey.cityTabuk.tr(),
    AppLocaleKey.cityBuraidah.tr(),
    AppLocaleKey.cityHail.tr(),
    AppLocaleKey.cityNajran.tr(),
    AppLocaleKey.cityJazan.tr(),
    AppLocaleKey.cityTaif.tr(),
    AppLocaleKey.cityJubail.tr(),
  ];

  double get _totalFinancing {
    final financed = _carPrice - _downPayment;
    if (financed <= 0) return 0;
    final profit = financed * (_apr / 100) * _durationYears;
    return financed + profit;
  }

  double get _monthlyInstallment {
    final total = _totalFinancing;
    if (total <= 0) return 0;
    return (total - _lastPayment) / (_durationYears * 12);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    _selectedCity = AppLocaleKey.cityRiyadh.tr();
    final raw = widget.car?['price']?.toString() ?? '150000';
    _carPrice =
        widget.initialCarPrice ??
        (double.tryParse(raw.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 150000);
    _downPayment = widget.initialDownPayment ?? 0;
    _durationYears = widget.initialDuration ?? 5;
    _downPaymentCtrl = TextEditingController(text: _downPayment.toStringAsFixed(1));
    _lastPaymentCtrl = TextEditingController(text: _lastPayment.toStringAsFixed(1));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCalculatorSheet(isInitial: true);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fullNameCtrl.dispose();
    _idCtrl.dispose();
    _phoneCtrl.dispose();
    _employerCtrl.dispose();
    _jobTitleCtrl.dispose();
    _salaryCtrl.dispose();
    _downPaymentCtrl.dispose();
    _lastPaymentCtrl.dispose();
    super.dispose();
  }

  void _showRequirementsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (ctx, scrollCtrl) => const FinancingRequirementsBottomSheet(),
      ),
    );
  }

  void _showCalculatorSheet({bool isInitial = false}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      isDismissible: !isInitial,
      enableDrag: !isInitial,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.92,
          maxChildSize: 0.97,
          minChildSize: 0.5,
          builder: (ctx, scrollCtrl) => FinancingCalculatorBottomSheet(
            carPrice: _carPrice,
            initialDownPayment: _downPayment,
            initialLastPayment: _lastPayment,
            initialDuration: _durationYears,
          ),
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _isCalculatorCompleted = true;
        _durationYears = result['duration'] ?? _durationYears;
        _downPayment = result['down'] ?? _downPayment;
        _lastPayment = result['last'] ?? _lastPayment;
        _downPaymentCtrl.text = _downPayment.toStringAsFixed(1);
        _lastPaymentCtrl.text = _lastPayment.toStringAsFixed(1);
      });
    } else if (isInitial && mounted) {
      // If user dismisses the bottom sheet on first load without applying, go back.
      Navigator.pop(context);
    }
  }

  void _onNextStep() async {
    final current = _tabController.index;
    if (current == 0) {
      if (!(_formKey1.currentState?.validate() ?? false)) return;
      if (_selectedGender == null) {
        _showSnack(AppLocaleKey.agentSelectGenderRequired.tr());
        return;
      }

      // OTP Verification
      final verified = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const FinancingOtpBottomSheet(),
      );
      if (verified != true) return;
    } else if (current == 1) {
      if (!(_formKey2.currentState?.validate() ?? false)) return;
      if (_employmentType == null) {
        _showSnack(AppLocaleKey.agentSelectEmploymentTypeRequired.tr());
        return;
      }
    } else if (current == 2) {
      // Submit Application
      _showSnack(AppLocaleKey.requestSubmittedSuccess.tr());
      // Optional: pop or navigate after success
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.of(context).pop();
      });
      return;
    }
    if (current < 2) _tabController.animateTo(current + 1);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.end),
        backgroundColor: AppColor.primaryColor(context),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  Future<void> _showCancelDialog() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppColor.orangeColor(context).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: AppColor.orangeColor(context),
                  size: 32.sp,
                ),
              ),
              Gap(20.h),
              Text(
                AppLocaleKey.agentCancelOrder.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyle.titleSmall(
                  context,
                ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
              ),
              Gap(12.h),
              Text(
                AppLocaleKey.agentCancelOrderDesc.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.greyColor(context), height: 1.5),
              ),
              Gap(24.h),
              CustomButton(
                radius: 12.r,
                onPressed: () => Navigator.pop(ctx, false),

                child: Text(
                  AppLocaleKey.agentContinueOrder.tr(),
                  style: AppTextStyle.bodyLarge(
                    context,
                  ).copyWith(color: AppColor.whiteColor(context)),
                ),
              ),
              Gap(10.h),
              CustomButton(
                onPressed: () => Navigator.pop(ctx, true),
                borderColor: AppColor.primaryColor(context),
                radius: 12.r,
                color: AppColor.whiteColor(context),
                child: Text(
                  AppLocaleKey.agentCancelOrder.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (shouldCancel == true && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCalculatorCompleted) {
      return Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        appBar: CustomAppBar(
          automaticallyImplyLeading: false,
          context,
          elevation: 0,
          leading: const SizedBox.shrink(),
        ),
        body: const SizedBox.shrink(),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _showCancelDialog();
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor(context),
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocaleKey.personalInfo.tr(),
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w900, color: AppColor.primaryColor(context)),
          ),
          leading: const SizedBox.shrink(),
          actions: [
            TextButton(
              onPressed: _showCancelDialog,
              child: Text(
                AppLocaleKey.cancel.tr(),
                style: TextStyle(
                  color: AppColor.greyColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(preferredSize: Size.fromHeight(48.h), child: _buildTabBar()),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [_buildPersonalInfoTab(), _buildWorkInfoTab(), _buildDocumentsTab()],
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  // ─────────────────────────── TAB BAR ────────────────────────────
  // Car summary card shown at top of personal info tab
  Widget _buildCarSummaryCard() {
    final fmt = NumberFormat('#,##0', 'en_US');
    final carName =
        widget.car?['name'] as String? ??
        widget.car?['model'] as String? ??
        AppLocaleKey.agentCarFallback.tr();
    final carYear = widget.car?['year']?.toString() ?? '';
    final monthly = _monthlyInstallment;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          // Top row: car name + monthly
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Monthly installment (left)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.agentFirstInstallment.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.greyColor(context), fontSize: 11.sp),
                  ),
                  Gap(4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        AppLocaleKey.agentYearly.tr(),
                        style: TextStyle(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp,
                        ),
                      ),
                      Gap(4.w),
                      Text(
                        fmt.format(monthly.round()),
                        style: TextStyle(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.w900,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppLocaleKey.agentMonthly.tr(),
                    style: TextStyle(
                      color: AppColor.primaryColor(context),
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              // Car name (right)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocaleKey.agentRequest.tr(),
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.greyColor(context), fontSize: 11.sp),
                    ),
                    Gap(4.h),
                    Text(
                      carName,
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w900, fontSize: 14.sp),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (carYear.isNotEmpty)
                      Text(
                        carYear,
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: AppColor.greyColor(context)),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Gap(14.h),
          Divider(height: 1, color: AppColor.dividerColor(context)),
          Gap(14.h),
          // Bottom row: duration, down payment, last payment + edit
          Row(
            children: [
              // Edit pencil button
              GestureDetector(
                onTap: _showCalculatorSheet,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor(context),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.edit_rounded, color: Colors.white, size: 16.sp),
                ),
              ),
              const Spacer(),
              // Last payment
              _buildSummaryChip(
                label: AppLocaleKey.agentLastPayment.tr(),
                value: '${AppLocaleKey.agentYearly.tr()}  ${_lastPayment.toStringAsFixed(1)}',
              ),
              Gap(16.w),
              // Down payment
              _buildSummaryChip(
                label: AppLocaleKey.agentFirstPayment.tr(),
                value: '${AppLocaleKey.agentYearly.tr()}   ${_downPayment.toStringAsFixed(1)}',
              ),
              Gap(16.w),
              // Duration
              _buildSummaryChip(
                label: AppLocaleKey.agentInstallmentsDuration.tr(),
                value: '$_durationYears  ${AppLocaleKey.agentYear.tr()}',
              ),
            ],
          ),
          Gap(14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded, color: AppColor.greyColor(context), size: 12.sp),
              Gap(4.w),
              Text(
                AppLocaleKey.agentEstimatePrices.tr(),
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontSize: 10.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryChip({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.greyColor(context), fontSize: 10.sp),
        ),
        Gap(2.h),
        Row(
          children: [
            Text(
              value,
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context),
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColor.appBarColor(context),
      child: IgnorePointer(
        child: TabBar(
          controller: _tabController,
          labelColor: AppColor.primaryColor(context),
          unselectedLabelColor: AppColor.greyColor(context),
          labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
          indicatorColor: AppColor.primaryColor(context),
          indicatorWeight: 2.5,
          tabs: [
            Tab(text: AppLocaleKey.agentTabTitle.tr()),
            Tab(text: AppLocaleKey.agentTabTitle2.tr()),
            Tab(text: AppLocaleKey.agentTabTitle3.tr()),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── TAB 1: Personal Info ───────────────────
  Widget _buildPersonalInfoTab() {
    return Form(
      key: _formKey1,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Car info summary card ──
            _buildCarSummaryCard(),
            Gap(20.h),
            Text(
              AppLocaleKey.agentEnterDetails.tr(),
              style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w700),
            ),
            Gap(10.h),
            // Full name field
            CustomFormField(
              controller: _fullNameCtrl,
              hintText: AppLocaleKey.agentFullName.tr(),
              radius: 12,
              validator: (v) => (v == null || v.isEmpty) ? AppLocaleKey.agentFullName.tr() : null,
            ),
            Gap(20.h),
            // Gender label
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
            // Gender toggle
            Row(
              children: [
                Expanded(child: _buildGenderButton('female', AppLocaleKey.agentFemale.tr())),
                Gap(12.w),
                Expanded(child: _buildGenderButton('male', AppLocaleKey.agentMale.tr())),
              ],
            ),
            Gap(20.h),
            // ID number
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
                if (v == null || v.isEmpty) return AppLocaleKey.agentNationalIdRequired.tr();
                if (v.length != 10) return AppLocaleKey.validateIdLength.tr();
                if (!v.startsWith('2')) return AppLocaleKey.validateIdStart.tr();
                return null;
              },
            ),
            Gap(16.h),
            // Phone number
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
                if (v == null || v.isEmpty) return AppLocaleKey.agentPhonesRequired.tr();
                if (v.length != 10) return AppLocaleKey.validatePhoneLength.tr();
                if (!v.startsWith('05')) return AppLocaleKey.validatePhoneStart.tr();
                return null;
              },
            ),
            Gap(16.h),
            // WhatsApp consent row
            GestureDetector(
              onTap: () => setState(() => _whatsappConsent = !_whatsappConsent),
              child: Row(
                children: [
                  // Checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: _whatsappConsent ? AppColor.primaryColor(context) : Colors.transparent,
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
                  // Whatsapp icon
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
            ),
            Gap(20.h),
            // City dropdown
            _buildCityDropdown(),
            Gap(20.h),
            // Requirements info banner
            _buildInfoBanner(),
            Gap(16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(String value, String label) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context).withOpacity(0.08)
              : AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor(context) : AppColor.borderColor(context),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyle.bodyMedium(context).copyWith(
              fontWeight: FontWeight.w700,
              color: isSelected ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
            ),
          ),
        ),
      ),
    );
  }

  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: AppColor.scaffoldColor(context),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Title
              Text(
                AppLocaleKey.agentCity.tr(),
                style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(16.h),
              Divider(height: 1, color: AppColor.dividerColor(context)),
              // List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  itemCount: _cities.length,
                  separatorBuilder: (context, index) => Gap(12.h),
                  itemBuilder: (context, index) {
                    final city = _cities[index];
                    final isSelected = city == _selectedCity;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedCity = city);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primaryColor(context).withValues(alpha: 0.1)
                              : AppColor.cardColor(context),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primaryColor(context)
                                : AppColor.borderColor(context),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColor.primaryColor(context),
                                size: 20.sp,
                              )
                            else
                              const SizedBox.shrink(),
                            Expanded(
                              child: Text(
                                city,
                                style: AppTextStyle.bodyMedium(context).copyWith(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected
                                      ? AppColor.primaryColor(context)
                                      : AppColor.blackTextColor(context),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCityDropdown() {
    return GestureDetector(
      onTap: _showCityBottomSheet,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.greyColor(context)),
            Text(
              _selectedCity ?? AppLocaleKey.agentCity.tr(),
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: _selectedCity == null
                    ? AppColor.hintColor(context)
                    : AppColor.blackTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return GestureDetector(
      onTap: _showRequirementsSheet,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: _showRequirementsSheet,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                AppLocaleKey.agentKnowMore.tr(),
                style: TextStyle(
                  color: AppColor.primaryColor(context),
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Spacer(),
            Text(
              AppLocaleKey.agentRequiredDocuments.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context).withOpacity(0.75),
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.end,
            ),
            Gap(10.w),
            Icon(Icons.calendar_today_outlined, color: AppColor.primaryColor(context), size: 18.sp),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── TAB 2: Work Info ───────────────────────
  Widget _buildWorkInfoTab() {
    return Form(
      key: _formKey2,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Employment type
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
                  child: _buildEmploymentTypeButton(
                    'private',
                    AppLocaleKey.agentPrivateSector.tr(),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: _buildEmploymentTypeButton('government', AppLocaleKey.agentGovSector.tr()),
                ),
                Gap(10.w),
                Expanded(
                  child: _buildEmploymentTypeButton('self', AppLocaleKey.agentFreelance.tr()),
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
            // Calculator banner
            _buildCalculatorBanner(),
            Gap(16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEmploymentTypeButton(String value, String label) {
    final isSelected = _employmentType == value;
    return GestureDetector(
      onTap: () => setState(() => _employmentType = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 11.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context).withOpacity(0.08)
              : AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor(context) : AppColor.borderColor(context),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              color: isSelected ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorBanner() {
    return GestureDetector(
      onTap: _showCalculatorSheet,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor(context).withOpacity(0.9),
              AppColor.primaryColor(context),
            ],
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calculate_outlined, color: Colors.white, size: 24.sp),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocaleKey.agentCalculateFinancingAmount.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14.sp,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    AppLocaleKey.agentKnowMonthlyInstallment.tr(),
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── TAB 3: Documents ───────────────────────
  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Requirements section
          _buildSectionCard(
            title: AppLocaleKey.agentFinancingRequirements.tr(),
            child: Column(
              children: [
                _buildRequirementRow(
                  icon: Icons.person_outline_rounded,
                  title: AppLocaleKey.agentCustomerAge.tr(),
                  value: AppLocaleKey.agentCustomerAgeLimit.tr(),
                  isLast: false,
                ),
                _buildRequirementRow(
                  icon: Icons.credit_card_rounded,
                  title: AppLocaleKey.agentDrivingLicense.tr(),
                  value: AppLocaleKey.agentValidLicense.tr(),
                  isLast: false,
                ),
                _buildRequirementRow(
                  icon: Icons.receipt_long_rounded,
                  title: AppLocaleKey.agentTrafficViolations.tr(),
                  value: AppLocaleKey.agentNoViolations.tr(),
                  isLast: true,
                ),
              ],
            ),
          ),
          Gap(24.h),
          // Documents section
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              AppLocaleKey.agentRequiredDocumentsList.tr(),
              style: AppTextStyle.titleSmall(
                context,
              ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
            ),
          ),
          Gap(14.h),
          _buildDocItem(AppLocaleKey.agentMinSalaryDoc.tr()),
          Gap(12.h),
          _buildDocItem(AppLocaleKey.agentNoSalaryTransfer.tr()),
          Gap(12.h),
          _buildDocItem(AppLocaleKey.agentEmployerNotApproved.tr()),
          Gap(12.h),
          _buildDocItem(AppLocaleKey.agentNoDownPaymentDoc.tr()),
          Gap(12.h),
          _buildDocItem(AppLocaleKey.agentLastPaymentDoc.tr()),
          Gap(24.h),
          // Upload section
          _buildUploadSection(),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: AppTextStyle.titleSmall(
            context,
          ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
        ),
        Gap(14.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.cardColor(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColor.borderColor(context)),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildRequirementRow({
    required IconData icon,
    required String title,
    required String value,
    required bool isLast,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
              ),
              Gap(12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                value,
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontSize: 12.sp),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: AppColor.dividerColor(context), indent: 16.w, endIndent: 16.w),
      ],
    );
  }

  Widget _buildDocItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, color: AppColor.greenColor(context), size: 20.sp),
        Gap(10.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), height: 1.4),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColor.primaryColor(context).withOpacity(0.3),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppLocaleKey.agentUploadDocuments.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
          ),
          Gap(12.h),
          _buildUploadTile(AppLocaleKey.agentNationalIdCopy.tr()),
          Gap(10.h),
          _buildUploadTile(AppLocaleKey.agentDrivingLicenseCopy.tr()),
          Gap(10.h),
          _buildUploadTile(AppLocaleKey.agentSalaryStatement.tr()),
        ],
      ),
    );
  }

  Widget _buildUploadTile(String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(context),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          children: [
            Icon(Icons.upload_file_outlined, color: AppColor.primaryColor(context), size: 20.sp),
            Gap(10.w),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context)),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── BOTTOM BAR ─────────────────────────────
  Widget _buildBottomBar() {
    final current = _tabController.index;
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          if (current > 0) ...[
            CustomButton(
              radius: 14.r,
              color: AppColor.cardColor(context),
              borderColor: AppColor.primaryColor(context),
              width: 50.w,
              onPressed: () => _tabController.animateTo(current - 1),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppColor.primaryColor(context),
                size: 20.sp,
              ),
            ),
            Gap(12.w),
          ],
          Expanded(
            child: CustomButton(
              radius: 14.r,
              color: AppColor.primaryColor(context),
              onPressed: _onNextStep,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (current < 2)
                    Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.whiteColor(context),
                      size: 18.sp,
                    ),
                  if (current < 2) Gap(10.w),
                  Text(
                    current == 2
                        ? AppLocaleKey.submitApplication.tr()
                        : AppLocaleKey.agentNext.tr(),
                    style: AppTextStyle.bodyLarge(
                      context,
                    ).copyWith(color: AppColor.whiteColor(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
