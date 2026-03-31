import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:car/features/services/presentation/widgets/financing_header.dart';
import 'package:car/features/services/presentation/widgets/financing_nav_actions.dart';
import 'package:car/features/services/presentation/widgets/financing_step_indicator.dart';
import 'package:car/features/services/presentation/widgets/steps/dashboard_step.dart';
import 'package:car/features/services/presentation/widgets/steps/platinum_step.dart';
import 'package:car/features/services/presentation/widgets/steps/schedule_step.dart';
import 'package:car/features/services/presentation/widgets/steps/showroom_step.dart';
import 'package:car/features/services/presentation/widgets/steps/signature_step.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ─────────────────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────────────────

final _kBrands = ['Mercedes', 'BMW', 'Toyota', 'Tesla', 'Audi', 'Lexus', 'Porsche'];

final _kModels = <String, List<String>>{
  'Mercedes': ['S-Class', 'G-Wagon', 'E-Class', 'GLE'],
  'BMW': ['X5', '7-Series', '5-Series', 'M4'],
  'Toyota': [
    'Raize',
    'Urban Cruiser',
    'Veloz',
    'Hilux',
    'Fortuner',
    'Yaris',
    'Corolla',
    'Highlander',
    'Innova',
    'Camry',
    'Land Cruiser',
    'Crown',
  ],
  'Tesla': ['Model S', 'Model X', 'Model 3', 'Model Y'],
  'Audi': ['A8', 'Q8', 'A6', 'RS7'],
  'Lexus': ['LX 600', 'LS 500', 'RX 350', 'ES 350'],
  'Porsche': ['911 Turbo', 'Taycan', 'Cayenne', 'Panamera'],
};

final _kBanks = <BankOffer>[
  BankOffer(
    nameKey: AppLocaleKey.bankAlrajhi,
    logoText: 'AR',
    baseApr: 3.5,
    brandColor: const Color(0xFF133261),
  ),
  BankOffer(
    nameKey: AppLocaleKey.bankSnb,
    logoText: 'SNB',
    baseApr: 2.9,
    brandColor: const Color(0xFF00755F),
    supportedBrands: ['Mercedes', 'BMW', 'Audi', 'Porsche', 'Toyota'],
    campaigns: [
      BankCampaign(brand: 'Toyota', model: 'Raize', year: 2024, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Urban Cruiser', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Veloz', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Hilux', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Fortuner', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Raize', year: 2026, rate: 2.80),
      BankCampaign(brand: 'Toyota', model: 'Urban Cruiser', year: 2026, rate: 2.80),
      BankCampaign(brand: 'Toyota', model: 'Hilux', year: 2026, rate: 2.80),
      BankCampaign(brand: 'Toyota', model: 'Yaris', year: 2026, rate: 2.99),
      BankCampaign(brand: 'Toyota', model: 'Corolla', year: 2026, rate: 2.99),
      BankCampaign(brand: 'Toyota', model: 'Corolla', year: 2025, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Highlander', year: 2025, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Innova', year: 2026, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Camry', year: 2026, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Fortuner', year: 2026, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Land Cruiser', year: 2026, rate: 3.20),
      BankCampaign(brand: 'Toyota', model: 'Crown', year: 2026, rate: 3.80),
    ],
  ),
  BankOffer(
    nameKey: AppLocaleKey.bankRiyad,
    logoText: 'RB',
    baseApr: 3.2,
    brandColor: const Color(0xFFCE1126),
    supportedBrands: ['Toyota', 'Lexus', 'Nissan'],
  ),
  BankOffer(
    nameKey: AppLocaleKey.bankAlinma,
    logoText: 'INM',
    baseApr: 3.0,
    brandColor: const Color(0xFF886A34),
  ),
];

// ─────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────

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
      _selectedBrand = _kBrands.firstWhere(
        (b) => b.toLowerCase() == (widget.car?['brand']?.toString().split('-').first.toLowerCase()),
        orElse: () => _kBrands[0],
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

  // ── Validation before advancing ──
  void _onNext() {
    if (_step == 0 && (_selectedBrand == null || _selectedModel == null)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('SELECTION REQUIRED')));
      return;
    }
    if (_step == 2 && _selectedBank == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PROVIDER SELECTION REQUIRED')));
      return;
    }
    if (_step < 4) {
      setState(() => _step++);
    } else if (_formKey.currentState!.validate()) {
      _showSuccess();
    }
  }

  void _onBack() => setState(() => _step--);

  // ── Bank selection with campaign auto-fill ──
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

  // ─────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.8),
                  radius: 1.2,
                  colors: [
                    AppColor.gradientSecondaryColor(context),
                    AppColor.scaffoldColor(context),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -50.h,
            left: 0,
            right: 0,
            child: Container(
              height: 300.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.whiteColor(context).withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
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

  // ─────────────────────────────────────────────────────────
  // STEP ROUTER
  // ─────────────────────────────────────────────────────────

  Widget _buildCurrentStep() {
    switch (_step) {
      case 0:
        return ShowroomStep(
          brands: _kBrands,
          models: _kModels,
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
          previewBank: _selectedBank ?? _kBanks[0],
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
          banks: _kBanks,
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
          selectedBank: _selectedBank ?? _kBanks[0],
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

  // ─────────────────────────────────────────────────────────
  // SUCCESS DIALOG
  // ─────────────────────────────────────────────────────────

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (ctx) => FadeInRight(
        child: AlertDialog(
          backgroundColor: AppColor.secondAppColor(context),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(20.h),
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 80.sp),
              ),
              Gap(32.h),
              Text(
                AppLocaleKey.requestSubmittedSuccess.tr().toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 18.sp),
              ),
              Gap(16.h),
              Text(
                AppLocaleKey.luxuryConciergeContact.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontSize: 13.sp),
              ),
              Gap(40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor(context),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: Text(
                    AppLocaleKey.ok.tr().toUpperCase(),
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.whiteColor(context),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Gap(10.h),
            ],
          ),
        ),
      ),
    );
  }
}
