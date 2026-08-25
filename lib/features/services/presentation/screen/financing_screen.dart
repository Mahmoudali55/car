import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/financing_ad_model.dart';
import 'package:car/features/services/presentation/widgets/financing_bottom_bar.dart';
import 'package:car/features/services/presentation/widgets/financing_calculator_bottom_sheet.dart';
import 'package:car/features/services/presentation/widgets/financing_cancel_dialog.dart';
import 'package:car/features/services/presentation/widgets/financing_documents_tab.dart';
import 'package:car/features/services/presentation/widgets/financing_otp_bottom_sheet.dart';
import 'package:car/features/services/presentation/widgets/financing_personal_info_tab.dart';
import 'package:car/features/services/presentation/widgets/financing_requirements_bottom_sheet.dart';
import 'package:car/features/services/presentation/widgets/financing_tab_bar.dart';
import 'package:car/features/services/presentation/widgets/financing_work_info_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancingScreen extends StatefulWidget {
  final GetBrandCarsDataModel? car;
  final double? initialCarPrice;
  final bool initialPriceIncludesVat;
  final double? initialDownPayment;
  final double? initialLastPayment;
  final int? initialDuration;
  final String? bankNameKey;
  final FinancingAdModel? offer;
  final List<FinancingAdModel> offers;

  const FinancingScreen({
    super.key,
    this.car,
    this.initialCarPrice,
    this.initialPriceIncludesVat = false,
    this.initialDownPayment,
    this.initialLastPayment,
    this.initialDuration,
    this.bankNameKey,
    this.offer,
    this.offers = const [],
  });

  @override
  State<FinancingScreen> createState() => _FinancingScreenState();
}

class _FinancingScreenState extends State<FinancingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool _isCalculatorCompleted = false;

  static const double _defaultApr = 4.5;

  late double _carPrice;
  int _durationYears = 5;
  double _downPayment = 0;
  double _lastPayment = 0;
  FinancingAdModel? _selectedOffer;

  FinancingAdModel? get _activeOffer => _selectedOffer ?? widget.offer;
  bool get _isOffer => _activeOffer != null;
  double get _apr => _activeOffer?.interestRate ?? _defaultApr;

  double get _financedAmount {
    final lastAmount = _carPrice * ((_activeOffer?.lastInstallmentPct ?? 0) / 100);
    final financed = _carPrice - _downPayment - (_isOffer ? lastAmount : 0);
    return financed > 0 ? financed : 0;
  }

  double get _totalFinancedWithInterest {
    return _financedAmount + _financedAmount * (_apr / 100) * _durationYears;
  }

  double get _monthlyInstallment {
    final total = _totalFinancedWithInterest;
    if (total <= 0) return 0;
    return (total - (_isOffer ? 0 : _lastPayment)) / (_durationYears * 12);
  }

  @override
  void initState() {
    super.initState();
    _selectedOffer = widget.offer ?? (widget.offers.isNotEmpty ? widget.offers.first : null);
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    final raw = widget.car?.price?.toString() ?? '150000';
    final cashPrice =
        widget.initialCarPrice ??
        (double.tryParse(raw.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 150000);
    final vatPercentage = double.tryParse(HiveMethods.getVatNumber()?.toString() ?? '') ?? 0;
    _carPrice = widget.initialPriceIncludesVat ? cashPrice : cashPrice * (1 + vatPercentage / 100);

    _downPayment =
        widget.initialDownPayment ?? (_carPrice * ((_activeOffer?.firstInstallmentPct ?? 0) / 100));
    _durationYears = (widget.initialDuration ?? ((_activeOffer?.totalMonths ?? 60) / 12).round())
        .clamp(1, 5);
    _lastPayment =
        widget.initialLastPayment ?? (_carPrice * ((_activeOffer?.lastInstallmentPct ?? 0) / 100));

    WidgetsBinding.instance.addPostFrameCallback((_) => _showCalculatorSheet(isInitial: true));
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        builder: (_, __) => const FinancingRequirementsBottomSheet(),
      ),
    );
  }

  Future<void> _showCalculatorSheet({bool isInitial = false}) async {
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
          builder: (_, __) => FinancingCalculatorBottomSheet(
            carPrice: _carPrice,
            initialDownPayment: _downPayment,
            initialLastPayment: _lastPayment,
            initialDuration: _durationYears,
            interestRate: _isOffer ? _apr : null,
            isOffer: _isOffer,
            bankName: _activeOffer?.displayBankName,
            firstInstallmentPct: _activeOffer?.firstInstallmentPct,
            lastInstallmentPct: _activeOffer?.lastInstallmentPct,
            adminFeesPct: _activeOffer?.adminFeesPct,
            offers: widget.offers,
            initialOffer: _activeOffer,
          ),
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        _isCalculatorCompleted = true;
        _durationYears = result['duration'] ?? _durationYears;
        _downPayment = result['down'] ?? _downPayment;
        _lastPayment = result['last'] ?? _lastPayment;
        if (result['offer'] is FinancingAdModel) {
          _selectedOffer = result['offer'];
        }
      });
    } else if (isInitial) {
      Navigator.pop(context);
    }
  }

  Future<void> _onNextStep() async {
    final current = _tabController.index;

    if (current == 0) {
      if (!(_formKey1.currentState?.validate() ?? false)) return;
      final verified = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const FinancingOtpBottomSheet(),
      );
      if (verified != true) return;
    } else if (current == 1) {
      if (!(_formKey2.currentState?.validate() ?? false)) return;
    } else if (current == 2) {
      _showSnack(AppLocaleKey.requestSubmittedSuccess.tr());
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
      builder: (ctx) => CancelDialog(context: ctx),
    );
    if (shouldCancel == true && mounted) Navigator.of(context).pop();
  }

  // ─── Build ───────────────────────────────────────────────────────

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
        appBar: _buildAppBar(),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FinancingPersonalInfoTab(
                formKey: _formKey1,
                car: widget.car?.toMap(),
                monthlyInstallment: _monthlyInstallment,
                durationYears: _durationYears,
                downPayment: _downPayment,
                lastPayment: _lastPayment,
                bankName: _activeOffer?.displayBankName,
                onEditCalculator: _showCalculatorSheet,
                onShowRequirements: _showRequirementsSheet,
              ),
              FinancingWorkInfoTab(formKey: _formKey2, onShowCalculator: _showCalculatorSheet),
              const FinancingDocumentsTab(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20.r),
          child: FinancingBottomBar(
            currentIndex: _tabController.index,
            onNext: _onNextStep,
            onBack: () => _tabController.animateTo(_tabController.index - 1),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.appBarColor(context),
      elevation: 0,
      centerTitle: true,
      leading: const SizedBox.shrink(),
      title: Text(
        AppLocaleKey.personalInfo.tr(),
        style: AppTextStyle.titleMedium(
          context,
        ).copyWith(fontWeight: FontWeight.w900, color: AppColor.primaryColor(context)),
      ),
      actions: [
        TextButton(
          onPressed: _showCancelDialog,
          child: Text(
            AppLocaleKey.cancel.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.bold),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.h),
        child: FinancingTabBar(controller: _tabController),
      ),
    );
  }
}
