import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/services/presentation/data/financing_constants.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:car/features/services/presentation/widgets/financing_background.dart';
import 'package:car/features/services/presentation/widgets/financing_header.dart';
import 'package:car/features/services/presentation/widgets/financing_nav_actions.dart';
import 'package:car/features/services/presentation/widgets/financing_step_indicator.dart';
import 'package:car/features/services/presentation/widgets/financing_success_dialog.dart';
import 'package:car/features/services/presentation/widgets/steps/dashboard_step.dart';
import 'package:car/features/services/presentation/widgets/steps/platinum_step.dart';
import 'package:car/features/services/presentation/widgets/steps/schedule_step.dart';
import 'package:car/features/services/presentation/widgets/steps/showroom_step.dart';
import 'package:car/features/services/presentation/widgets/steps/signature_step.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancingScreen extends StatefulWidget {
  final Map<String, dynamic>? car;
  const FinancingScreen({super.key, this.car});

  @override
  State<FinancingScreen> createState() => _FinancingScreenState();
}

class _FinancingScreenState extends State<FinancingScreen> {
  // ── Wizard state ──
  int _step = 0;

  // ── Step 0: Selection ──
  String? _selectedBrand;
  String? _selectedModel;
  int _selectedYear = 2025;

  // ── Step 1: Calculator ──
  late double _carPrice;
  double _downPaymentPercent = 10;
  double _lastPaymentPercent = 0;
  int _durationYears = 5;

  // ── Step 2: Bank ──
  BankOffer? _selectedBank;

  // ── Step 4: Form ──
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _workCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final raw = widget.car?['price']?.toString() ?? '150000';
    _carPrice = double.tryParse(raw.replaceAll(RegExp(r'[^0-9]'), '')) ?? 150000;

    if (widget.car != null) {
      _selectedBrand = kBrands.firstWhere(
        (b) => b.toLowerCase() == (widget.car?['brand']?.toString().split('-').first.toLowerCase()),
        orElse: () => kBrands[0],
      );
      _selectedModel = widget.car?['name'] ?? widget.car?['model'] ?? 'S-Class';
      _selectedYear = int.tryParse(widget.car?['year']?.toString() ?? '2025') ?? 2025;
      _step = 1;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _idCtrl.dispose();
    _workCtrl.dispose();
    _salaryCtrl.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_step == 0 && (_selectedBrand == null || _selectedModel == null)) {
      CommonMethods.showToast(message: 'VEHICLE SELECTION REQUIRED', type: ToastType.error);
      return;
    }
    if (_step == 2 && _selectedBank == null) {
      CommonMethods.showToast(message: 'BANK SELECTION REQUIRED', type: ToastType.error);
      return;
    }
    if (_step < 4) {
      setState(() => _step++);
    } else if (_formKey.currentState!.validate()) {
      _showSuccess();
    }
  }

  void _onBack() => setState(() => _step--);

  void _selectBank(BankOffer bank) {
    setState(() {
      _selectedBank = bank;
      if (bank.campaigns != null) {
        for (final c in bank.campaigns!) {
          if (c.matches(_selectedBrand ?? '', _selectedModel ?? '', _selectedYear)) {
            _downPaymentPercent = c.defaultDownPayment;
            _lastPaymentPercent = c.defaultLastPayment;
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Stack(
        children: [
          const FinancingBackground(),
          SafeArea(
            child: Column(
              children: [
                const FinancingHeader(),
                FinancingStepIndicator(currentStep: _step),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(key: _formKey, child: _buildCurrentStep()),
                  ),
                ),
                FinancingNavActions(
                  currentStep: _step,
                  onBack: _onBack,
                  onNext: _onNext,
                  nextLabel: _step == 4 ? AppLocaleKey.sendRequest.tr() : AppLocaleKey.next.tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_step) {
      case 0:
        return ShowroomStep(
          brands: kBrands,
          models: kModels,
          selectedBrand: _selectedBrand,
          selectedModel: _selectedModel,
          selectedYear: _selectedYear,
          onBrandSelected: (b) => setState(() {
            _selectedBrand = b;
            _selectedModel = null;
          }),
          onModelSelected: (m) => setState(() => _selectedModel = m),
          onYearChanged: (y) => setState(() => _selectedYear = y),
        );
      case 1:
        return DashboardStep(
          previewBank: _selectedBank ?? kBanks[0],
          carPrice: _carPrice,
          downPaymentPercent: _downPaymentPercent,
          lastPaymentPercent: _lastPaymentPercent,
          durationYears: _durationYears,
          selectedYear: _selectedYear,
          selectedBrand: _selectedBrand ?? '',
          selectedModel: _selectedModel ?? '',
          onCarPriceChanged: (v) => setState(() => _carPrice = v),
          onDownPaymentChanged: (v) => setState(() => _downPaymentPercent = v),
          onLastPaymentChanged: (v) => setState(() => _lastPaymentPercent = v),
          onDurationChanged: (v) => setState(() => _durationYears = v.toInt()),
        );
      case 2:
        return PlatinumStep(
          banks: kBanks,
          selectedBank: _selectedBank,
          selectedBrand: _selectedBrand ?? '',
          selectedModel: _selectedModel ?? '',
          selectedYear: _selectedYear,
          carPrice: _carPrice,
          downPaymentPercent: _downPaymentPercent,
          lastPaymentPercent: _lastPaymentPercent,
          durationYears: _durationYears,
          onBankSelected: _selectBank,
        );
      case 3:
        return ScheduleStep(
          selectedBank: _selectedBank ?? kBanks[0],
          carPrice: _carPrice,
          downPaymentPercent: _downPaymentPercent,
          lastPaymentPercent: _lastPaymentPercent,
          durationYears: _durationYears,
          selectedYear: _selectedYear,
          selectedBrand: _selectedBrand ?? '',
          selectedModel: _selectedModel ?? '',
        );
      case 4:
        return SignatureStep(
          nameController: _nameCtrl,
          phoneController: _phoneCtrl,
          idController: _idCtrl,
          workController: _workCtrl,
          salaryController: _salaryCtrl,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showSuccess() {
    showDialog(context: context, builder: (ctx) => const FinancingSuccessDialog());
  }
}
