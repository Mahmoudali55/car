import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentMethodSelectorWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final String title;

  const PaymentMethodSelectorWidget({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.title,
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
        Gap(12.h),
        Row(
          children: [
            _PaymentMethodChip(
              isSelected: selectedIndex == 0,
              icon: Icons.credit_card_rounded,
              label: AppLocaleKey.paymentMethodCardLabel.tr(),
              onTap: () => onSelected(0),
            ),
            Gap(12.w),
            _PaymentMethodChip(
              isSelected: selectedIndex == 1,
              icon: Icons.apple_rounded,
              label: 'Apple Pay',
              onTap: () => onSelected(1),
            ),
            Gap(12.w),
            _PaymentMethodChip(
              isSelected: selectedIndex == 2,
              icon: Icons.payment_rounded,
              label: AppLocaleKey.paymentMethodMadaLabel.tr(),
              onTap: () => onSelected(2),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentMethodChip extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PaymentMethodChip({
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
}
