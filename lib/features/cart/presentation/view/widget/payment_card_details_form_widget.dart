import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/widget/payment_form_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentCardDetailsFormWidget extends StatelessWidget {
  final String title;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final ValueChanged<String> onCardNumberChanged;
  final ValueChanged<String> onCardHolderChanged;
  final ValueChanged<String> onExpiryChanged;
  final ValueChanged<String> onCvvChanged;

  const PaymentCardDetailsFormWidget({
    super.key,
    required this.title,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.expiryController,
    required this.cvvController,
    required this.onCardNumberChanged,
    required this.onCardHolderChanged,
    required this.onExpiryChanged,
    required this.onCvvChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w700),
        ),
        Gap(16.h),
        PaymentFormFieldWidget(
          controller: cardNumberController,
          label: AppLocaleKey.paymentCardNumberLabel.tr(),
          hint: '0000 0000 0000 0000',
          icon: Icons.credit_card_rounded,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          onChanged: onCardNumberChanged,
          validator: (v) {
            if (v == null || v.replaceAll(' ', '').length < 16) {
              return AppLocaleKey.paymentCardNumberInvalidMessage.tr();
            }
            return null;
          },
        ),
        Gap(14.h),
        PaymentFormFieldWidget(
          controller: cardHolderController,
          label: AppLocaleKey.paymentCardHolderLabel.tr(),
          hint: 'AHMED ALI',
          icon: Icons.person_outline_rounded,
          textCapitalization: TextCapitalization.characters,
          onChanged: onCardHolderChanged,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return AppLocaleKey.paymentCardHolderInvalidMessage.tr();
            }
            return null;
          },
        ),
        Gap(14.h),
        Row(
          children: [
            Expanded(
              child: PaymentFormFieldWidget(
                controller: expiryController,
                label: AppLocaleKey.paymentExpiryLabel.tr(),
                hint: 'MM/YY',
                icon: Icons.date_range_rounded,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: onExpiryChanged,
                validator: (v) {
                  if (v == null || v.length < 5) {
                    return AppLocaleKey.paymentExpiryInvalidMessage.tr();
                  }
                  return null;
                },
              ),
            ),
            Gap(12.w),
            Expanded(
              child: PaymentFormFieldWidget(
                controller: cvvController,
                label: 'CVV',
                hint: '•••',
                icon: Icons.security_rounded,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                obscureText: true,
                onChanged: onCvvChanged,
                validator: (v) {
                  if (v == null || v.length < 3) return AppLocaleKey.paymentCvvInvalidMessage.tr();
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
