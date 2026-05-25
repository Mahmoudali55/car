import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
import 'package:car/features/cars/presentation/screen/financing_info_screen.dart';
import 'package:car/features/cars/presentation/screen/reservation_success_screen.dart';
import 'package:car/features/cars/presentation/screen/widget/card_expiry_formatter_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/card_number_formatter_widget.dart';
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
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

enum _ReservationScreenStep { methodSelection, informationEntry, payment }

class CarReservationScreen extends StatefulWidget {
  final Map<String, dynamic> car;
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

  // Cash payment form controllers
  final _paymentFormKey = GlobalKey<FormState>();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvcController = TextEditingController();

  // Financing flow controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _financePhoneController = TextEditingController();
  final ValueNotifier<bool> _whatsappNotifier = ValueNotifier(true);
  final ValueNotifier<String?> _selectedCityNotifier = ValueNotifier('الرياض');

  double _totalPrice = 0.0;
  final double _depositAmount = 500.0;

  @override
  void initState() {
    super.initState();
    _totalPrice = _parsePrice(widget.car['price']);
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
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCvcController.dispose();
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
    context.read<CartCubit>().addToCart(widget.car);
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
      builder: (_) => DraggableScrollableSheet(
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
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: OtpBottomSheet(
          phoneNumber: _cashPhoneController.text,
          onVerified: () {
            Navigator.pop(context);
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
          final msg = status.data?.msg ?? (isArabic ? 'تم الحفظ بنجاح' : 'Saved successfully');
          CommonMethods.showToast(message: msg, type: ToastType.success);
          _navigateToSuccess();
        } else if (status.isFailure) {
          setState(() => _isLoading = false);

          CommonMethods.showToast(
            message:
                status.error ??
                (isArabic ? 'حدث خطأ أثناء حفظ الحجز' : 'Error occurred while saving reservation'),
            type: ToastType.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        appBar: AppBar(
          title: Text(
            isMethodSelection
                ? AppLocaleKey.agentSelectPaymentMethod.tr()
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
          title: AppLocaleKey.cash.tr(),
          badgeText: AppLocaleKey.agent500.tr(),
          description: AppLocaleKey.agentPriceIncludesVat.tr(),
          isSelected: _selectedMethod == 'cash',
          onTap: () => setState(() => _selectedMethod = 'cash'),
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
              Text(
                '${_depositAmount.toInt()} SAR',
                style: AppTextStyle.buttonStyle(context).copyWith(fontWeight: FontWeight.bold),
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
    return Form(
      key: _paymentFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Step Indicator tabs
          _buildPaymentStepIndicator(),
          Gap(24.h),

          // 2. Custom Car summary card
          _buildBespokeCarSummaryCard(),
          Gap(32.h),

          // 3. Name on Card Field
          Text(
            isArabic ? 'الاسم على البطاقة' : 'Cardholder Name',
            style: AppTextStyle.bodyMedium(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.8),
            ),
          ),
          Gap(8.h),
          CustomFormField(
            controller: _cardNameController,
            hintText: isArabic ? 'الاسم على البطاقة' : 'Cardholder Name',
            radius: 12,
            validator: (value) => value == null || value.isEmpty
                ? AppLocaleKey.paymentCardHolderInvalidMessage.tr()
                : null,
          ),
          Gap(20.h),

          // 4. Card Details Merged Input Field
          Text(
            isArabic ? 'معلومات البطاقة' : 'Card Information',
            style: AppTextStyle.bodyMedium(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.8),
            ),
          ),
          Gap(8.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.borderColor(context)),
              color: AppColor.secondAppColor(context),
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: '1234 5678 9101 1121',
                    hintStyle: AppTextStyle.hintStyle(
                      context,
                      listen: false,
                    ).copyWith(color: AppColor.hintColor(context)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'mada',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(4.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D47A1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'VISA',
                            style: TextStyle(
                              color: AppColor.whiteColor(context),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(4.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'mc',
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(8.w),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocaleKey.paymentCardNumberInvalidMessage.tr();
                    }
                    final cleanValue = value.replaceAll(RegExp(r'\s+|-'), '');
                    if (cleanValue.length < 15 || cleanValue.length > 19) {
                      return AppLocaleKey.paymentCardNumberInvalidMessage.tr();
                    }
                    return null;
                  },
                ),
                const Divider(height: 1),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cardExpiryController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                          LengthLimitingTextInputFormatter(5),
                          CardExpiryFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: 'MM / YY',
                          hintStyle: TextStyle(color: AppColor.hintColor(context), fontSize: 13.sp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocaleKey.paymentExpiryInvalidMessage.tr();
                          }
                          final cleanValue = value.replaceAll(RegExp(r'\s+'), '');
                          final parts = cleanValue.split('/');
                          if (parts.length != 2) {
                            return AppLocaleKey.paymentExpiryInvalidMessage.tr();
                          }
                          final month = int.tryParse(parts[0]);
                          final year = int.tryParse(parts[1]);
                          if (month == null || month < 1 || month > 12) {
                            return AppLocaleKey.paymentExpiryInvalidMessage.tr();
                          }
                          if (year == null || year < 24 || year > 50) {
                            return AppLocaleKey.paymentExpiryInvalidMessage.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(width: 1, height: 40.h, color: AppColor.borderColor(context)),
                    Expanded(
                      child: TextFormField(
                        controller: _cardCvcController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        decoration: InputDecoration(
                          hintText: 'CVC',
                          hintStyle: TextStyle(color: AppColor.hintColor(context), fontSize: 13.sp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocaleKey.paymentCvvInvalidMessage.tr();
                          }
                          final cleanValue = value.trim();
                          if (cleanValue.length < 3 || cleanValue.length > 4) {
                            return AppLocaleKey.paymentCvvInvalidMessage.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(40.h),

          // 5. Green Pay Button
          CustomButton(
            height: 56.h,
            width: double.infinity,
            radius: 12.r,
            color: const Color(0xff00c853),
            onPressed: _isLoading ? null : _submitPayment,
            child: _isLoading
                ? CircularProgressIndicator(color: AppColor.whiteColor(context))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_depositAmount.toInt()} ﷼',
                        style: AppTextStyle.buttonStyle(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      Gap(16.w),
                      Text(
                        isArabic ? 'أتمم لدفع العربون' : 'Complete Deposit Payment',
                        style: AppTextStyle.buttonStyle(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ],
                  ),
          ),
          Gap(24.h),

          // 6. Guarantee Banner
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
      ),
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
              Text(
                '${_totalPrice.toStringAsFixed(2)} ﷼',
                style: TextStyle(
                  color: const Color(0xFF0D47A1),
                  fontWeight: FontWeight.w900,
                  fontSize: 16.sp,
                ),
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
                        widget.car['name'] ?? 'Car Name',
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.blackTextColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.car['year']?.toString() ?? '2023',
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
    final brandName = widget.car['brand']?.toString().toLowerCase() ?? '';
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

  void _submitPayment() {
    if (!_paymentFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final futureDateStr = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now().add(const Duration(days: 1)));

    final itemCode =
        widget.car['itemCode']?.toString() ?? widget.car['ITEM_CODE']?.toString() ?? '';
    final itemName =
        widget.car['itemName']?.toString() ??
        widget.car['ITEM_NAME']?.toString() ??
        widget.car['name']?.toString() ??
        '';
    final chassisNo =
        widget.car['chassisNo']?.toString() ?? widget.car['CHASSIS_NO']?.toString() ?? '';
    final storeCodeVal =
        int.tryParse(
          widget.car['storeCode']?.toString() ?? widget.car['STORE_CODE']?.toString() ?? '1',
        ) ??
        1;

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
      notes: 'حجز سيارة كاش - ${_cashNameController.text} (${_cashPhoneController.text})',
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
