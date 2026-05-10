import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/payment_method_selection_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SelectionBodyWidget extends StatefulWidget {
  const SelectionBodyWidget({super.key});

  @override
  State<SelectionBodyWidget> createState() => _SelectionBodyWidgetState();
}

class _SelectionBodyWidgetState extends State<SelectionBodyWidget> {
  String? _selectedMethod;
  bool get _isFinancingFlow => _selectedMethod == 'tamara' || _selectedMethod == 'bank';
  @override
  Widget build(BuildContext context) {
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
            'assets/images/tamara_logo.png',
            height: 24.h,
            errorBuilder: (c, e, s) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF7B2D8B), Color(0xFFE91E8C)]),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                AppLocaleKey.agentTamara.tr(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12.sp),
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
}
