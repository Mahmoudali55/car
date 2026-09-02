import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/home/data/model/customer_loan_application_model.dart';
import 'package:car/features/profile/presentation/screen/widget/info_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancialGrid extends StatelessWidget {
  const FinancialGrid({super.key, required this.application, required this.formatter});
  final CustomerLoanApplicationModel application;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final sarText = AppLocaleKey.sar.tr();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InfoTile(
                label: AppLocaleKey.carPrice.tr(),
                value: '${formatter.format(application.carPrice)} $sarText',
                icon: Icons.sell_rounded,
                context: context,
              ),
            ),
            Gap(10.w),
            Expanded(
              child: InfoTile(
                label: AppLocaleKey.loanAmount.tr(),
                value: '${formatter.format(application.loanAmount)} $sarText',
                icon: Icons.account_balance_wallet_rounded,
                context: context,
              ),
            ),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Expanded(
              child: InfoTile(
                label: AppLocaleKey.downPayment.tr(),
                value: '${formatter.format(application.downPayment)} $sarText',
                icon: Icons.payments_rounded,
                context: context,
              ),
            ),
            Gap(10.w),
            Expanded(
              child: InfoTile(
                label: AppLocaleKey.monthlyInstallment.tr(),
                value: '${formatter.format(application.monthlyInstallment)} $sarText',
                icon: Icons.event_repeat_rounded,
                context: context,
                highlight: true,
              ),
            ),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Expanded(
              child: InfoTile(
                label: AppLocaleKey.financeDuration.tr(),
                value: '${application.termMonths} ${AppLocaleKey.monthsCount.tr()}',
                icon: Icons.timer_rounded,
                context: context,
              ),
            ),
            Gap(10.w),
            Expanded(
              child: InfoTile(
                label: AppLocaleKey.adLastPayment.tr(),
                value: application.lastPayment > 0
                    ? '${formatter.format(application.lastPayment)} $sarText'
                    : AppLocaleKey.noLastPayment.tr(),
                icon: Icons.flag_rounded,
                context: context,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
