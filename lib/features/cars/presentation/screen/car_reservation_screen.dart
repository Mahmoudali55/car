import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/screen/financing_info_screen.dart';
import 'package:car/features/cars/presentation/screen/reservation_success_screen.dart';
import 'package:car/features/cars/presentation/widget/buying_faq_section_widget.dart';
import 'package:car/features/cars/presentation/widget/car_summary_card_widget.dart';
import 'package:car/features/cars/presentation/widget/financing_contact_form.dart';
import 'package:car/features/cars/presentation/widget/otp_bottom_sheet.dart';
import 'package:car/features/cars/presentation/widget/payment_method_selection_card.dart';
import 'package:car/features/cars/presentation/widget/pricing_details_bottom_sheet.dart';
import 'package:car/features/cars/presentation/widget/reservation_pricing_card.dart';
import 'package:car/features/cars/presentation/widget/reservation_step_indicator.dart';
import 'package:car/features/cars/presentation/widget/reservation_trust_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

enum _ReservationScreenStep { methodSelection, informationEntry }

class CarReservationScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  final bool isFromLink;

  const CarReservationScreen({
    super.key,
    required this.car,
    this.isFromLink = false,
  });

  @override
  State<CarReservationScreen> createState() => _CarReservationScreenState();
}

class _CarReservationScreenState extends State<CarReservationScreen> {
  _ReservationScreenStep _currentStep = _ReservationScreenStep.methodSelection;
  String? _selectedMethod;

  // Cash flow controllers
  final TextEditingController _cashNameController = TextEditingController();
  final TextEditingController _cashPhoneController = TextEditingController();

  // Financing flow controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _financePhoneController = TextEditingController();
  final ValueNotifier<bool> _whatsappNotifier = ValueNotifier(true);
  final ValueNotifier<String?> _selectedCityNotifier = ValueNotifier('الرياض');

  final double _totalPrice = 44338.75;
  final double _depositAmount = 500.0;

  bool get _isFinancingFlow =>
      _selectedMethod == 'tamara' || _selectedMethod == 'bank';

  @override
  void dispose() {
    _cashNameController.dispose();
    _cashPhoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _financePhoneController.dispose();
    _whatsappNotifier.dispose();
    _selectedCityNotifier.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_selectedMethod == null) return;

    if (_isFinancingFlow) {
      // Tamara / Bank → go directly to dedicated screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FinancingInfoScreen(
            car: widget.car,
            paymentMethod: _selectedMethod!,
            totalPrice: _totalPrice,
          ),
        ),
      );
    } else {
      // Cash → inline second step then OTP
      if (_currentStep == _ReservationScreenStep.methodSelection) {
        setState(() => _currentStep = _ReservationScreenStep.informationEntry);
      } else {
        _showOtpSheet();
      }
    }
  }

  void _navigateToSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReservationSuccessScreen(
          car: widget.car,
          paymentMethod: _selectedMethod!,
        ),
      ),
    );
  }

  void _showPricingDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: PricingDetailsBottomSheet(
            car: widget.car,
            totalPrice: _totalPrice,
          ),
        ),
      ),
    );
  }

  void _showOtpSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: OtpBottomSheet(
          phoneNumber: _cashPhoneController.text,
          onVerified: () {
            Navigator.pop(context);
            _navigateToSuccess();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMethodSelection =
        _currentStep == _ReservationScreenStep.methodSelection;

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        title: Text(
          isMethodSelection
              ? 'اختر الطريقة المناسبة للشراء'
              : widget.car['name'] ?? 'Car',
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
            color: isMethodSelection
                ? AppColor.blackTextColor(context)
                : AppColor.primaryColor(context),
          ),
        ),
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
        ],
        leading: isMethodSelection
            ? const SizedBox.shrink()
            : IconButton(
                icon: Icon(Icons.chevron_right_rounded,
                    color: AppColor.blackTextColor(context)),
                onPressed: () => setState(
                    () => _currentStep = _ReservationScreenStep.methodSelection),
              ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMethodSelection) ...[
              CarSummaryCard(car: widget.car),
              Gap(24.h),
              _buildSelectionBody(),
              Gap(40.h),
              const BuyingFaqSection(),
            ] else ...[
              ReservationStepIndicator(
                currentStep: 0,
                isFinancingFlow: _isFinancingFlow,
              ),
              Gap(8.h),
              if (_isFinancingFlow)
                _buildFinancingPricingCard()
              else
                ReservationPricingCard(
                  totalPrice: _totalPrice,
                  depositAmount: _depositAmount,
                ),
              Gap(32.h),
              Text(
                _isFinancingFlow ? 'ادخل معلوماتك' : 'معلومات التواصل',
                style: AppTextStyle.titleMedium(context).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                ),
              ),
              Gap(16.h),
              if (_isFinancingFlow)
                FinancingContactForm(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  phoneController: _financePhoneController,
                  whatsappNotifier: _whatsappNotifier,
                  selectedCityNotifier: _selectedCityNotifier,
                )
              else ...[
                CustomFormField(
                  controller: _cashNameController,
                  hintText: 'الاسم بالكامل',
                  radius: 12,
                ),
                Gap(16.h),
                CustomFormField(
                  controller: _cashPhoneController,
                  hintText: 'رقم الجوال',
                  radius: 12,
                  keyboardType: TextInputType.phone,
                ),
                Gap(32.h),
                const ReservationTrustBadge(),
              ],
            ],
            Gap(100.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildStickyFooter(),
    );
  }

  Widget _buildSelectionBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentMethodSelectionCard(
          title: 'كاش',
          badgeText: '500 ر.س مستردة',
          description: 'اضمن حجز السيارة من خلال دفع عربون مخصوم من قيمة السيارة.',
          isSelected: _selectedMethod == 'cash',
          onTap: () => setState(() => _selectedMethod = 'cash'),
        ),
        Gap(32.h),
        Text(
          'اشتري الآن، ادفع لاحقاً!',
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
        Gap(16.h),
        PaymentMethodSelectionCard(
          title: 'تمارا',
          description: 'قسط قيمة سيارتك - بدون رسوم تأخير، متوافقة مع الشريعة الإسلامية.',
          logo: Image.asset(
            'assets/images/tamara_logo.png',
            height: 24.h,
            errorBuilder: (c, e, s) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF7B2D8B), Color(0xFFE91E8C)]),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text('تمارا',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.sp)),
            ),
          ),
          isSelected: _selectedMethod == 'tamara',
          onTap: () => setState(() => _selectedMethod = 'tamara'),
        ),
        Gap(16.h),
        PaymentMethodSelectionCard(
          title: 'قسط عبر بطاقة الراجحي او الاهلي الائتمانية',
          description: 'قسمها حتى 24 شهر - بدون رسوم.',
          logo: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(Icons.account_balance, color: Colors.white, size: 14.sp),
              ),
              Gap(8.w),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF003366),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(Icons.account_balance_wallet, color: Colors.white, size: 14.sp),
              ),
            ],
          ),
          isSelected: _selectedMethod == 'bank',
          onTap: () => setState(() => _selectedMethod = 'bank'),
        ),
      ],
    );
  }

  Widget _buildFinancingPricingCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المبلغ الإجمالي',
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.blackTextColor(context).withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.payments_outlined,
                        size: 18.sp,
                        color: AppColor.blackTextColor(context)),
                    Gap(6.w),
                    Text(
                      '${_totalPrice.toStringAsFixed(2)} SAR',
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showPricingDetails,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2F7),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
              ),
              child: Center(
                child: Text(
                  'إعرض التفاصيل',
                  style: TextStyle(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter() {
    final bool isMethodSelection =
        _currentStep == _ReservationScreenStep.methodSelection;
    final bool canContinue = _selectedMethod != null;

    String buttonLabel = 'المتابعة';
    Color buttonColor = canContinue
        ? AppColor.primaryColor(context)
        : (Colors.grey[300] ?? Colors.grey);

    if (!isMethodSelection) {
      if (_isFinancingFlow) {
        buttonLabel = _selectedMethod == 'tamara'
            ? 'متابعة مع تمارا'
            : 'متابعة مع البنك';
        buttonColor = const Color(0xFF3F51B5);
      } else {
        buttonLabel = 'اكمل لدفع العربون';
        buttonColor = const Color(0xff00c853);
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: CustomButton(
        height: 56.h,
        width: double.infinity,
        radius: 12.r,
        color: canContinue ? buttonColor : (Colors.grey[300] ?? Colors.grey),
        onPressed: canContinue ? _handleContinue : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMethodSelection && !_isFinancingFlow) ...[
              Text(
                '${_depositAmount.toInt()} SAR',
                style: AppTextStyle.buttonStyle(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(16.w),
            ],
            if (_isFinancingFlow && !isMethodSelection) ...[
              Icon(Icons.arrow_back_rounded, color: Colors.white, size: 18.sp),
              Gap(12.w),
            ],
            Text(
              buttonLabel,
              style: AppTextStyle.buttonStyle(context).copyWith(
                color: canContinue ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
