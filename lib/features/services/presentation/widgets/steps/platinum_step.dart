import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:car/features/services/presentation/widgets/shared/bank_offer_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PlatinumStep extends StatelessWidget {
  final List<BankOffer> banks;
  final BankOffer? selectedBank;
  final String selectedBrand;
  final String selectedModel;
  final int selectedYear;
  final double carPrice;
  final double downPaymentPercent;
  final double lastPaymentPercent;
  final int durationYears;
  final void Function(BankOffer bank) onBankSelected;

  const PlatinumStep({
    super.key,
    required this.banks,
    required this.selectedBank,
    required this.selectedBrand,
    required this.selectedModel,
    required this.selectedYear,
    required this.carPrice,
    required this.downPaymentPercent,
    required this.lastPaymentPercent,
    required this.durationYears,
    required this.onBankSelected,
  });

  @override
  Widget build(BuildContext context) {
    final supportedBanks = banks.where((b) => b.isBrandSupported(selectedBrand)).toList();

    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.viewOffers.tr().toUpperCase(),
            style: AppTextStyle.titleMedium(context).copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          Gap(16.h),
          if (supportedBanks.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  AppLocaleKey.noOffersAvailable.tr(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.greyColor(context),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            ...supportedBanks.map((bank) => BankOfferCard(
                  bank: bank,
                  isSelected: selectedBank == bank,
                  carPrice: carPrice,
                  downPaymentPercent: downPaymentPercent,
                  lastPaymentPercent: lastPaymentPercent,
                  durationYears: durationYears,
                  selectedYear: selectedYear,
                  selectedBrand: selectedBrand,
                  selectedModel: selectedModel,
                  onTap: () => onBankSelected(bank),
                )),
        ],
      ),
    );
  }
}
