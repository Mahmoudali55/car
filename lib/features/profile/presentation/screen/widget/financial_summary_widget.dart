import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/agent/data/model/customer_profile_model.dart';
import 'package:car/features/profile/presentation/screen/widget/info_tile_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FinancialSummaryWidget extends StatelessWidget {
  const FinancialSummaryWidget({super.key, required this.profile});

  final CustomerProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 80),
      child: SectionWidget(
        title: AppLocaleKey.financialSummary.tr(),
        children: [
          if (profile?.balance != null)
            InfoTileWidget(
              icon: Icons.account_balance_wallet_outlined,
              label: AppLocaleKey.currentBalance.tr(),
              value: '${profile?.formattedBalance} ${AppLocaleKey.sar.tr()}',
            ),
          if (profile?.creditLimit != null)
            InfoTileWidget(
              icon: Icons.credit_score_outlined,
              label: AppLocaleKey.creditLimit.tr(),
              value: '${profile?.creditLimit} ${AppLocaleKey.sar.tr()}',
            ),
        ],
      ),
    );
  }
}
