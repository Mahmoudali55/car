import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
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

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // ─── State ───────────────────────────────────────────────────────

  bool _isCalculatorCompleted = false;

  // ─── Calculator State ────────────────────────────────────────────

  static const double _apr = 4.5;

  late double _carPrice;
  int _durationYears = 5;
  double _downPayment = 0;
  double _lastPayment = 0;

  // ─── Computed Properties ─────────────────────────────────────────

  double get _totalFinancing {
    final financed = _carPrice - _downPayment;
    if (financed <= 0) return 0;
    return financed + financed * (_apr / 100) * _durationYears;
  }

  double get _monthlyInstallment {
    final total = _totalFinancing;
    if (total <= 0) return 0;
    return (total - _lastPayment) / (_durationYears * 12);
  }

  // ─── Lifecycle ───────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    final raw = widget.car?['price']?.toString() ?? '150000';
    _carPrice =
        widget.initialCarPrice ??
        (double.tryParse(raw.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 150000);

    _downPayment = widget.initialDownPayment ?? 0;
    _durationYears = widget.initialDuration ?? 5;

    WidgetsBinding.instance.addPostFrameCallback((_) => _showCalculatorSheet(isInitial: true));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ─── Bottom Sheets ───────────────────────────────────────────────

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
      });
    } else if (isInitial) {
      Navigator.pop(context);
    }
  }

  // ─── Step Navigation ─────────────────────────────────────────────

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

  // ─── Helpers ─────────────────────────────────────────────────────

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
                car: widget.car,
                monthlyInstallment: _monthlyInstallment,
                durationYears: _durationYears,
                downPayment: _downPayment,
                lastPayment: _lastPayment,
                onEditCalculator: _showCalculatorSheet,
                onShowRequirements: _showRequirementsSheet,
              ),
              FinancingWorkInfoTab(formKey: _formKey2, onShowCalculator: _showCalculatorSheet),
              FinancingDocumentsTab(),
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
