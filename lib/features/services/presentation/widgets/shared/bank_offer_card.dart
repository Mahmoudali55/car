import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankOfferCard extends StatelessWidget {
  final BankOffer bank;
  final bool isSelected;
  final double monthlyInstallment;
  final double totalAmount;
  final double apr;
  final VoidCallback onTap;

  const BankOfferCard({
    super.key,
    required this.bank,
    required this.isSelected,
    required this.monthlyInstallment,
    required this.totalAmount,
    required this.apr,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColor.primaryColor(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isSelected
              ? primary.withOpacity(0.05)
              : AppColor.cardColor(context).withOpacity(0.4),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? primary : AppColor.borderColor(context),
            width: isSelected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Logo
            Container(
              height: 54.h,
              width: 54.h,
              decoration: BoxDecoration(
                color: bank.brandColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  bank.logoText.toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.whiteColor(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Gap(20.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bank.nameKey.tr().toUpperCase(),
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w900,
                      color: isSelected
                          ? primary
                          : AppColor.blackTextColor(context).withOpacity(0.7),
                      fontSize: 13.sp,
                      letterSpacing: 1,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    '${AppLocaleKey.fixedApr.tr().toUpperCase()}: ${apr.toStringAsFixed(2)}%',
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blackTextColor(context).withOpacity(0.4),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Monthly amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  NumberFormat('#,##0').format(monthlyInstallment),
                  style: AppTextStyle.titleMedium(context).copyWith(
                    color: isSelected
                        ? primary
                        : AppColor.blackTextColor(context).withOpacity(0.7),
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  AppLocaleKey.sar.tr().toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.blackTextColor(context).withOpacity(0.4),
                    fontWeight: FontWeight.w900,
                    fontSize: 10.sp,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
