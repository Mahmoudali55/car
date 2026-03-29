import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({super.key, required this.totalPrice});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _isLoading = false;
  int _selectedPayment = 0; // 0: Card, 1: Apple Pay, 2: Mada

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  String _formatCardNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digitsOnly[i]);
    }
    return buffer.toString();
  }

  String _formatExpiry(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length >= 2) {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2)}';
    }
    return digitsOnly;
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushNamed(context, RoutesName.paymentSuccessScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldColor(context),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: AppColor.blackTextColor(context).withOpacity(0.05),
          ),
        ),
        title: Text(
          'الدفع الآمن',
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(Icons.lock_rounded, color: AppColor.primaryColor(context), size: 22.sp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16.h),

              // Payment Method Selection
              Text(
                'طريقة الدفع',
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w700),
              ),
              Gap(12.h),
              Row(
                children: [
                  _buildPaymentMethod(0, Icons.credit_card_rounded, 'بطاقة'),
                  Gap(12.w),
                  _buildPaymentMethod(1, Icons.apple_rounded, 'Apple Pay'),
                  Gap(12.w),
                  _buildPaymentMethod(2, Icons.payment_rounded, 'مدى'),
                ],
              ),
              Gap(28.h),

              // Card Preview
              _buildCardPreview(context),
              Gap(28.h),

              // Card Details Form
              Text(
                'بيانات البطاقة',
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w700),
              ),
              Gap(16.h),

              // Card Number
              _buildFormField(
                controller: _cardNumberController,
                label: 'رقم البطاقة',
                hint: '0000 0000 0000 0000',
                icon: Icons.credit_card_rounded,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                onChanged: (v) {
                  final formatted = _formatCardNumber(v);
                  if (formatted != v) {
                    _cardNumberController.value = _cardNumberController.value.copyWith(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                  setState(() {});
                },
                validator: (v) {
                  if (v == null || v.replaceAll(' ', '').length < 16) {
                    return 'أدخل رقم بطاقة صحيح';
                  }
                  return null;
                },
              ),
              Gap(14.h),

              // Card Holder
              _buildFormField(
                controller: _cardHolderController,
                label: 'اسم حامل البطاقة',
                hint: 'AHMED ALI',
                icon: Icons.person_outline_rounded,
                textCapitalization: TextCapitalization.characters,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'أدخل اسم حامل البطاقة';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              Gap(14.h),

              // Expiry & CVV
              Row(
                children: [
                  Expanded(
                    child: _buildFormField(
                      controller: _expiryController,
                      label: 'تاريخ الانتهاء',
                      hint: 'MM/YY',
                      icon: Icons.date_range_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onChanged: (v) {
                        final formatted = _formatExpiry(v);
                        if (formatted != v) {
                          _expiryController.value = _expiryController.value.copyWith(
                            text: formatted,
                            selection: TextSelection.collapsed(offset: formatted.length),
                          );
                        }
                        setState(() {});
                      },
                      validator: (v) {
                        if (v == null || v.length < 5) {
                          return 'تاريخ غير صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: _buildFormField(
                      controller: _cvvController,
                      label: 'CVV',
                      hint: '•••',
                      icon: Icons.security_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      obscureText: true,
                      onChanged: (_) => setState(() {}),
                      validator: (v) {
                        if (v == null || v.length < 3) return 'CVV غير صحيح';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(32.h),

              // Price Summary
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                decoration: BoxDecoration(
                  color: AppColor.secondAppColor(context),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.06)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(context, 'مجموع السيارات', _formatPrice(widget.totalPrice)),
                    Gap(10.h),
                    _buildSummaryRow(context, 'رسوم الخدمة', '2,500  ر.س       '),
                    Gap(10.h),
                    Divider(color: AppColor.blackTextColor(context).withOpacity(0.1)),
                    Gap(10.h),
                    _buildSummaryRow(
                      context,
                      'الإجمالي',
                      _formatPrice(widget.totalPrice + 2500),
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              Gap(28.h),

              // Pay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor(context),
                    disabledBackgroundColor: AppColor.primaryColor(context).withOpacity(0.5),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 22.h,
                          width: 22.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation(AppColor.blackTextColor(context)),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              color: AppColor.whiteColor(context),
                              size: 20.sp,
                            ),
                            Gap(10.w),
                            Text(
                              AppLocaleKey.payNow.tr(),
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: AppColor.whiteColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Gap(12.h),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: AppColor.blackTextColor(context).withOpacity(0.4),
                      size: 14.sp,
                    ),
                    Gap(6.w),
                    Text(
                      'مدفوعات آمنة بتشفير SSL',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.blackTextColor(context).withOpacity(0.4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(int index, IconData icon, String label) {
    final isSelected = _selectedPayment == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPayment = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.primaryColor(context).withOpacity(0.15)
                : AppColor.secondAppColor(context),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isSelected
                  ? AppColor.primaryColor(context)
                  : AppColor.blackTextColor(context).withOpacity(0.06),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColor.primaryColor(context)
                    : AppColor.blackTextColor(context).withOpacity(0.5),
                size: 22.sp,
              ),
              Gap(4.h),
              Text(
                label,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: isSelected
                      ? AppColor.primaryColor(context)
                      : AppColor.blackTextColor(context).withOpacity(0.5),
                  fontSize: 10.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview(BuildContext context) {
    final cardNumber = _cardNumberController.text.isEmpty
        ? '•••• •••• •••• ••••'
        : _cardNumberController.text.padRight(19, '•');
    final cardHolder = _cardHolderController.text.isEmpty
        ? 'الاسم الكامل'
        : _cardHolderController.text;
    final expiry = _expiryController.text.isEmpty ? 'MM/YY' : _expiryController.text;

    return Container(
      height: 190.h,
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.primaryColor(context), AppColor.primaryColor(context).withOpacity(0.6)],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor(context).withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VISA',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
              ),
              Icon(
                Icons.wifi_rounded,
                color: AppColor.blackTextColor(context).withOpacity(0.8),
                size: 24.sp,
              ),
            ],
          ),
          Text(
            cardNumber,
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حامل البطاقة',
                    style: TextStyle(
                      color: AppColor.blackTextColor(context).withOpacity(0.6),
                      fontSize: 9.sp,
                    ),
                  ),
                  Text(
                    cardHolder,
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاريخ الانتهاء',
                    style: TextStyle(
                      color: AppColor.blackTextColor(context).withOpacity(0.6),
                      fontSize: 9.sp,
                    ),
                  ),
                  Text(
                    expiry,
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.6), fontSize: 12.sp),
        ),
        Gap(8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          validator: validator,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.25)),
            prefixIcon: Icon(icon, color: AppColor.primaryColor(context), size: 20.sp),
            filled: true,
            fillColor: AppColor.secondAppColor(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: AppColor.blackTextColor(context).withOpacity(0.06)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: AppColor.primaryColor(context), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: isTotal
                ? AppColor.blackTextColor(context)
                : AppColor.blackTextColor(context).withOpacity(0.6),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: isTotal ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 16.sp : 14.sp,
          ),
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    final formatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    return '$formatted  ر.س       ';
  }
}
