import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/payment_method_selection_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationMethodSelection extends StatelessWidget {
  final String? selectedMethod;
  final ValueChanged<String> onMethodChanged;

  const ReservationMethodSelection({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentMethodSelectionCard(
          title: AppLocaleKey.payment_types.tr(),
          badgeText: AppLocaleKey.agent500.tr(),
          description: AppLocaleKey.agentPriceIncludesVat.tr(),
          logo: Row(
            children: [
              _iconBadge(Icons.credit_card_rounded, AppColor.primaryColor(context), context),
              Gap(8.w),
              _iconBadge(Icons.apple, AppColor.blackColor(context), context),
            ],
          ),
          isSelected: selectedMethod == 'moyasar',
          onTap: () => onMethodChanged('moyasar'),
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
          isSelected: selectedMethod == 'tamara',
          onTap: () => onMethodChanged('tamara'),
        ),
        Gap(16.h),
        PaymentMethodSelectionCard(
          title: AppLocaleKey.agentCreditCard.tr(),
          description: AppLocaleKey.agent24Months.tr(),
          logo: Row(
            children: [
              _iconBadge(Icons.account_balance, AppColor.greenColor(context), context),
              Gap(8.w),
              _iconBadge(Icons.account_balance_wallet, const Color(0xFF003366), context),
            ],
          ),
          isSelected: selectedMethod == 'bank',
          onTap: () => onMethodChanged('bank'),
        ),
      ],
    );
  }

  Widget _iconBadge(IconData icon, Color color, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6.r)),
      child: Icon(icon, color: AppColor.whiteColor(context), size: 14.sp),
    );
  }
}
