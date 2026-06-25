import 'dart:convert';
import 'dart:io';

import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
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
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/home/data/model/add_booking_permission_model.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moyasar/moyasar.dart';

enum _ReservationScreenStep { methodSelection, informationEntry, payment }

class CarReservationScreen extends StatefulWidget {
  final GetBrandCarsDataModel car;
  final bool isFromLink;

  const CarReservationScreen({super.key, required this.car, this.isFromLink = false});

  @override
  State<CarReservationScreen> createState() => _CarReservationScreenState();
}

class _CarReservationScreenState extends State<CarReservationScreen> {
  _ReservationScreenStep _currentStep = _ReservationScreenStep.methodSelection;
  String? _selectedMethod;
  bool _isLoading = false;

  // Cash flow controllers
  final _infoFormKey = GlobalKey<FormState>();
  final TextEditingController _cashNameController = TextEditingController();
  final TextEditingController _cashPhoneController = TextEditingController();

  // Financing flow controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _financePhoneController = TextEditingController();
  final ValueNotifier<bool> _whatsappNotifier = ValueNotifier(true);
  final ValueNotifier<String?> _selectedCityNotifier = ValueNotifier('الرياض');

  double _totalPrice = 0.0;
  final double _depositAmount = 500.0;
  late Map<String, dynamic> _errorCodes;
  @override
  void initState() {
    super.initState();
    _totalPrice = _parsePrice(widget.car.price);
    _loadErrorCodes();
  }

  Future<void> _loadErrorCodes() async {
    final String data = await rootBundle.loadString('assets/payment_error_codes.json');
    setState(() => _errorCodes = jsonDecode(data));
  }

  double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is num) return price.toDouble();
    if (price is String) {
      // Remove everything except digits and decimal point
      final cleanPrice = price.replaceAll(RegExp(r'[^0-9.]'), '');
      final parsed = double.tryParse(cleanPrice) ?? 0.0;
      return parsed.isFinite ? parsed : 0.0;
    }
    return 0.0;
  }

  bool get _isFinancingFlow => _selectedMethod == 'tamara' || _selectedMethod == 'bank';

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
        if (!_infoFormKey.currentState!.validate()) return;
        _showOtpSheet();
      }
    }
  }

  void _navigateToSuccess() {
    context.read<CartCubit>().addToCart(widget.car.toMap());
    HiveMethods.removeFromRecentlyViewed(widget.car.itemName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReservationSuccessScreen(car: widget.car, paymentMethod: _selectedMethod!),
      ),
    );
  }

  void _showPricingDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: PricingDetailsBottomSheet(car: widget.car, totalPrice: _totalPrice),
        ),
      ),
    );
  }

  void _showOtpSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: OtpBottomSheet(
          phoneNumber: _cashPhoneController.text,
          onVerified: () {
            Navigator.pop(ctx);
            setState(() {
              _currentStep = _ReservationScreenStep.payment;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';
    final bool isMethodSelection = _currentStep == _ReservationScreenStep.methodSelection;

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        final status = state.addBookingPermissionResponseModel;
        if (status.isSuccess) {
          setState(() => _isLoading = false);
          final msg = status.data?.msg ?? '';
          CommonMethods.showToast(message: msg, type: ToastType.success);
          _navigateToSuccess();
        } else if (status.isFailure) {
          setState(() => _isLoading = false);

          CommonMethods.showToast(message: status.error ?? '', type: ToastType.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        appBar: AppBar(
          title: Text(
            isMethodSelection ? AppLocaleKey.agentSelectPaymentMethod.tr() : widget.car.itemName,
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
                AppLocaleKey.agentCancel.tr(),
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
            ),
          ],
          leading: isMethodSelection
              ? const SizedBox.shrink()
              : IconButton(
                  icon: Icon(Icons.chevron_right_rounded, color: AppColor.blackTextColor(context)),
                  onPressed: () {
                    if (_currentStep == _ReservationScreenStep.payment) {
                      setState(() => _currentStep = _ReservationScreenStep.informationEntry);
                    } else {
                      setState(() => _currentStep = _ReservationScreenStep.methodSelection);
                    }
                  },
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
              ] else if (_currentStep == _ReservationScreenStep.payment) ...[
                _buildPaymentBody(),
              ] else ...[
                ReservationStepIndicator(currentStep: 0, isFinancingFlow: _isFinancingFlow),
                Gap(8.h),
                if (_isFinancingFlow)
                  _buildFinancingPricingCard()
                else
                  ReservationPricingCard(totalPrice: _totalPrice, depositAmount: _depositAmount),
                Gap(32.h),
                Text(
                  _isFinancingFlow
                      ? AppLocaleKey.agentEnterDetails.tr()
                      : AppLocaleKey.agentContactInfo.tr(),
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900, fontSize: 20.sp),
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
                  Form(
                    key: _infoFormKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: _cashNameController,
                          hintText: AppLocaleKey.agentFullName.tr(),
                          radius: 12,
                          validator: (value) => value == null || value.isEmpty
                              ? AppLocaleKey.validateEmpty.tr()
                              : null,
                        ),
                        Gap(16.h),
                        CustomFormField(
                          controller: _cashPhoneController,
                          hintText: AppLocaleKey.agentPhone.tr(),
                          radius: 12,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocaleKey.validateEmpty.tr();
                            }
                            if (value.length < 10) {
                              return context.locale.languageCode == 'ar'
                                  ? 'رقم الجوال يجب أن يكون 10 أرقام'
                                  : 'Phone number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
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
      ),
    );
  }

  Widget _buildSelectionBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentMethodSelectionCard(
          title: AppLocaleKey.payment_types.tr(),
          badgeText: AppLocaleKey.agent500.tr(),
          description: AppLocaleKey.agentPriceIncludesVat.tr(),
          logo: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.credit_card_rounded,
                  color: AppColor.whiteColor(context),
                  size: 14.sp,
                ),
              ),
              Gap(8.w),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColor.blackColor(context),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(Icons.apple, color: AppColor.whiteColor(context), size: 14.sp),
              ),
            ],
          ),
          isSelected: _selectedMethod == 'moyasar',
          onTap: () => setState(() => _selectedMethod = 'moyasar'),
        ),
        Gap(32.h),
        Text(
          AppLocaleKey.agentBuyNowPayLater.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: 20.sp),
        ),
        Gap(16.h),
        PaymentMethodSelectionCard(
          title: AppLocaleKey.agentTamara.tr(),
          description: AppLocaleKey.agentNoFees.tr(),
          logo: Image.asset(
            AppImages.assetsImagesTamaraLogo,
            height: 24.h,
            errorBuilder: (c, e, s) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF7B2D8B), Color(0xFFE91E8C)]),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                AppLocaleKey.agentTamara.tr(),
                style: TextStyle(
                  color: AppColor.whiteColor(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          isSelected: _selectedMethod == 'tamara',
          onTap: () => setState(() => _selectedMethod = 'tamara'),
        ),
        Gap(16.h),
        PaymentMethodSelectionCard(
          title: AppLocaleKey.agentCreditCard.tr(),
          description: AppLocaleKey.agent24Months.tr(),
          logo: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColor.greenColor(context),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: AppColor.whiteColor(context),
                  size: 14.sp,
                ),
              ),
              Gap(8.w),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF003366),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: AppColor.whiteColor(context),
                  size: 14.sp,
                ),
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
                  AppLocaleKey.agentTotalPrice.tr(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 18.sp,
                      color: AppColor.blackTextColor(context),
                    ),
                    Gap(6.w),
                    Text(
                      '${_totalPrice.toStringAsFixed(2)} SAR',
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
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
                  AppLocaleKey.agentShowDetails.tr(),
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

  Widget? _buildStickyFooter() {
    if (_currentStep == _ReservationScreenStep.payment) {
      return null;
    }
    final bool isMethodSelection = _currentStep == _ReservationScreenStep.methodSelection;
    final bool canContinue = _selectedMethod != null;

    String buttonLabel = AppLocaleKey.agentContinue.tr();
    Color buttonColor = canContinue
        ? AppColor.primaryColor(context)
        : (Colors.grey[300] ?? Colors.grey);

    if (!isMethodSelection) {
      if (_isFinancingFlow) {
        buttonLabel = _selectedMethod == 'tamara'
            ? AppLocaleKey.agentContinueWithTamara.tr()
            : AppLocaleKey.agentContinueWithBank.tr();
        buttonColor = const Color(0xFF3F51B5);
      } else {
        buttonLabel = AppLocaleKey.agentCompletePayment.tr();
        buttonColor = const Color(0xff00c853);
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.06),
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
              ValueWithCurrencyIcon(
                text: '${_depositAmount.toInt()} SAR',
                textStyle: AppTextStyle.buttonStyle(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(16.w),
            ],
            if (_isFinancingFlow && !isMethodSelection) ...[
              Icon(Icons.arrow_back_rounded, color: AppColor.whiteColor(context), size: 18.sp),
              Gap(12.w),
            ],
            Text(
              buttonLabel,
              style: AppTextStyle.buttonStyle(context).copyWith(
                color: canContinue ? AppColor.whiteColor(context) : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentBody() {
    final isArabic = context.locale.languageCode == 'ar';

    // Moyasar PaymentConfig: 500 SAR = 50000 halalas
    final paymentConfig = PaymentConfig(
      publishableApiKey: Constants.moyasarPublishableKey,
      amount: (_depositAmount * 100).toInt(), // 500 SAR → 50000 halalas
      description: isArabic
          ? 'حجز سيارة ${widget.car.itemName}'
          : 'Car Reservation - ${widget.car.itemName}',
      metadata: {
        'item_code': widget.car.itemCode,
        'chassis_no': widget.car.chassisNo,
        'customer_name': _cashNameController.text,
        'customer_phone': _cashPhoneController.text,
      },
      creditCard: CreditCardConfig(saveCard: false, manual: false),
      applePay: ApplePayConfig(
        merchantId: Constants.applePayMerchantId,
        label: isArabic ? 'شركة معرض السيارات' : 'Car Dealership App',
        manual: false,
        saveCard: false,
      ),
      supportedNetworks: const [
        PaymentNetwork.mada,
        PaymentNetwork.visa,
        PaymentNetwork.masterCard,
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Step Indicator
        _buildPaymentStepIndicator(),
        Gap(24.h),

        // 2. Car Summary
        _buildBespokeCarSummaryCard(),
        Gap(24.h),

        // 3. Deposit amount banner
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.primaryColor(context),
                AppColor.primaryColor(context).withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline_rounded, color: AppColor.whiteColor(context), size: 20.sp),
              Gap(10.w),
              Text(
                isArabic
                    ? 'مبلغ العربون: ${_depositAmount.toInt()} ${AppLocaleKey.sar.tr()} '
                    : 'Deposit Amount: ${_depositAmount.toInt()} SAR',
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Gap(24.h),

        // 4. Moyasar widgets (official SDK)
        Text(
          isArabic ? 'اختر طريقة الدفع' : 'Choose Payment Method',
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: 18.sp),
        ),
        Gap(8.h),
        Row(
          children: [
            _buildNetworkBadge('Visa', Colors.blue.shade900),
            Gap(8.w),
            _buildNetworkBadge('Mastercard', Colors.orange.shade800),
            Gap(8.w),
            _buildNetworkBadge('Mada', Colors.blue.shade700),
            if (Platform.isIOS) ...[Gap(8.w), _buildNetworkBadge('Apple Pay', Colors.black)],
          ],
        ),
        Gap(16.h),

        // Loading overlay or Moyasar widgets
        if (_isLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Column(
                children: [
                  CircularProgressIndicator(color: AppColor.primaryColor(context)),
                  Gap(16.h),
                  Text(
                    isArabic ? 'جارٍ معالجة الدفع...' : 'Processing payment...',
                    style: AppTextStyle.bodyMedium(context),
                  ),
                ],
              ),
            ),
          )
        else ...[
          if (Platform.isIOS) ...[
            ApplePay(
              config: paymentConfig,
              onPaymentResult: (result) => _handlePaymentResult(result, isApplePay: true),
            ),
            Gap(16.h),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    isArabic ? 'أو الدفع باستخدام البطاقة' : 'Or pay with credit card',
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.greyColor(context)),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            Gap(16.h),
          ],
          CreditCard(
            config: paymentConfig,
            onPaymentResult: (result) => _handlePaymentResult(result, isApplePay: false),
          ),
        ],

        Gap(24.h),

        // 5. Guarantee Banner
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFC8E6C9)),
          ),
          child: Row(
            children: [
              Icon(Icons.verified_user_rounded, color: const Color(0xFF2E7D32), size: 24.sp),
              Gap(12.w),
              Expanded(
                child: Text(
                  AppLocaleKey.about.tr(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(60.h),
      ],
    );
  }

  Widget _buildPaymentStepIndicator() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                AppLocaleKey.payment.tr(),
                style: TextStyle(
                  color: const Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Gap(8.h),
              Container(
                height: 3.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D47A1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                AppLocaleKey.addInfo.tr(),
                style: TextStyle(
                  color: const Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Gap(8.h),
              Container(
                height: 3.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBespokeCarSummaryCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF0D47A1), size: 24.sp),
              Gap(8.w),
              ValueWithCurrencyIcon(
                text: '${_totalPrice.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}',
                textStyle: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: const Color(0xFF0D47A1), fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Gap(12.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.car.itemName,
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.blackTextColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.car.makeYear.toString(),
                        style: TextStyle(color: AppColor.greyColor(context), fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                Gap(12.w),
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.scaffoldColor(context),
                    border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.5)),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: _buildBrandLogo(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo() {
    final brandName = widget.car.groupName.toLowerCase();
    String? logoPath;

    for (final b in BrandModel.brands) {
      if (b.name.toLowerCase() == brandName && b.logo.isNotEmpty) {
        logoPath = b.logo;
        break;
      }
    }

    if (logoPath != null && logoPath.isNotEmpty) {
      return Image.asset(
        logoPath,
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Icon(
          Icons.directions_car_filled_rounded,
          color: AppColor.primaryColor(context),
          size: 20.sp,
        ),
      );
    }

    return Icon(
      Icons.directions_car_filled_rounded,
      color: AppColor.primaryColor(context),
      size: 20.sp,
    );
  }

  Widget _buildNetworkBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12.sp),
      ),
    );
  }

  void _handlePaymentResult(dynamic result, {required bool isApplePay}) {
    if (result is PaymentResponse) {
      if (result.status == PaymentStatus.paid) {
        _submitPayment(paymentId: result.id);
      } else {
        String? code;
        String? fallback;

        if (isApplePay && result.source is ApplePayPaymentResponseSource) {
          final src = result.source as ApplePayPaymentResponseSource;
          fallback = src.message;
        } else if (!isApplePay && result.source is CardPaymentResponseSource) {
          final src = result.source as CardPaymentResponseSource;

          fallback = src.message;
        }

        CommonMethods.showToast(
          message: _translateRawMessage(fallback ?? 'Payment failed, please try again'),
          type: ToastType.error,
        );
      }
    }
  }

  String _translateRawMessage(String message) {
    final isArabic = context.locale.languageCode == 'ar';
    final lang = isArabic ? 'ar' : 'en';
    final msg = message.toLowerCase();

    // ابحث في كل الـ JSON عن أقرب رسالة مطابقة
    for (final entry in _errorCodes.entries) {
      final enText = (entry.value['en'] as String).toLowerCase();
      if (msg.contains(enText) || enText.contains(msg)) {
        return entry.value[lang];
      }
    }

    return isArabic ? 'فشل الدفع، يرجى المحاولة مجدداً' : 'Payment failed, please try again';
  }

  void _submitPayment({String? paymentId}) {
    if (mounted) setState(() => _isLoading = true);

    final todayStr = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    final futureDateStr = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now().add(const Duration(days: 1)));

    final itemCode = widget.car.itemCode;
    final itemName = widget.car.itemName;
    final chassisNo = widget.car.chassisNo;
    final storeCodeVal = int.tryParse(widget.car.storeCode) ?? 1;

    final paymentNote = paymentId != null
        ? 'Moyasar ID: $paymentId'
        : 'حجز سيارة كاش - ${_cashNameController.text} (${_cashPhoneController.text})';

    final model = AddBookingPermissionModel(
      lpoNos: '',
      lpono: '',
      listNo: 0,
      analytical: '',
      customerNo: 5,
      represCode: 1,
      fDate: todayStr,
      lDate: futureDateStr,
      lpoDate: todayStr,
      storeCode: storeCodeVal,
      taamedNo: '',
      payCond: '',
      guarFinal: 0,
      notes: paymentNote,
      userName: HiveMethods.getUserName() ?? '',
      subLpo: [
        SubLpoModel(
          itemCode: itemCode,
          itemName: itemName,
          chassisNo: chassisNo,
          price: _totalPrice.toDouble(),
          advancedAmount: _depositAmount.toDouble(),
          lpoNo: '',
          lpoType: 3,
          storeCode: storeCodeVal,
          transDate: todayStr,
          fDate: todayStr,
          lDate: futureDateStr,
          userName: HiveMethods.getUserName() ?? '',
        ),
      ],
    );

    context.read<HomeCubit>().getAddBookingPermission(model);
  }
}
