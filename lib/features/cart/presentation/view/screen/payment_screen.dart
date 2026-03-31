import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:car/features/cart/presentation/view/widget/payment_app_bar_widget.dart';
import 'package:car/features/cart/presentation/view/widget/payment_card_details_form_widget.dart';
import 'package:car/features/cart/presentation/view/widget/payment_card_preview_widget.dart';
import 'package:car/features/cart/presentation/view/widget/payment_method_selector_widget.dart';
import 'package:car/features/cart/presentation/view/widget/payment_order_summary_widget.dart';
import 'package:car/features/cart/presentation/view/widget/payment_pay_button_widget.dart';
import 'package:car/features/cart/presentation/view/widget/payment_ssl_note_widget.dart';
import 'package:flutter/material.dart';
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
      appBar: PaymentAppBarWidget(title: AppLocaleKey.paymentScreenTitle.tr()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16.h),

              PaymentMethodSelectorWidget(
                title: AppLocaleKey.paymentMethodTitle.tr(),
                selectedIndex: _selectedPayment,
                onSelected: (i) => setState(() => _selectedPayment = i),
              ),
              Gap(28.h),

              PaymentCardPreviewWidget(
                cardNumber: _cardNumberController.text.isEmpty
                    ? '•••• •••• •••• ••••'
                    : _cardNumberController.text.padRight(19, '•'),
                cardHolder: _cardHolderController.text.isEmpty
                    ? AppLocaleKey.paymentCardHolderPlaceholder.tr()
                    : _cardHolderController.text,
                expiry: _expiryController.text.isEmpty ? 'MM/YY' : _expiryController.text,
              ),
              Gap(28.h),

              PaymentCardDetailsFormWidget(
                title: AppLocaleKey.paymentCardDetailsTitle.tr(),
                cardNumberController: _cardNumberController,
                cardHolderController: _cardHolderController,
                expiryController: _expiryController,
                cvvController: _cvvController,
                onCardNumberChanged: (v) {
                  final formatted = _formatCardNumber(v);
                  if (formatted != v) {
                    _cardNumberController.value = _cardNumberController.value.copyWith(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                  setState(() {});
                },
                onCardHolderChanged: (_) => setState(() {}),
                onExpiryChanged: (v) {
                  final formatted = _formatExpiry(v);
                  if (formatted != v) {
                    _expiryController.value = _expiryController.value.copyWith(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                  setState(() {});
                },
                onCvvChanged: (_) => setState(() {}),
              ),
              Gap(32.h),

              PaymentOrderSummaryWidget(
                carsTotalLabel: AppLocaleKey.paymentCarsTotalLabel.tr(),
                serviceFeeLabel: AppLocaleKey.paymentServiceFeeLabel.tr(),
                totalLabel: AppLocaleKey.total.tr(),
                carsTotalValue: _formatPrice(widget.totalPrice),
                serviceFeeValue: _formatPrice(2500),
                totalValue: _formatPrice(widget.totalPrice + 2500),
              ),
              Gap(28.h),

              PaymentPayButtonWidget(
                isLoading: _isLoading,
                onPressed: _processPayment,
                title: AppLocaleKey.payNow.tr(),
              ),
              Gap(12.h),
              PaymentSslNoteWidget(text: AppLocaleKey.paymentSslNote.tr()),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    final formatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    return '$formatted ${AppLocaleKey.sar.tr()}       ';
  }
}
