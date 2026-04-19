import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/bank_offer_sort_chip_widget.dart';
import 'package:car/features/cars/presentation/widget/bank_offers_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankOfferFilterSection extends StatelessWidget {
  final SortOption currentSort;
  final ValueChanged<SortOption> onSortChanged;
  const BankOfferFilterSection({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.sortBy.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColor.blackTextColor(context),
            ),
          ),
          Gap(12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                BankOfferSortChip(
                  label: AppLocaleKey.lowestMargin.tr(),
                  option: SortOption.lowestMargin,
                  isSelected: currentSort == SortOption.lowestMargin,
                  onTap: () => onSortChanged(SortOption.lowestMargin),
                ),
                Gap(12.w),
                BankOfferSortChip(
                  label: AppLocaleKey.highestMargin.tr(),
                  option: SortOption.highestMargin,
                  isSelected: currentSort == SortOption.highestMargin,
                  onTap: () => onSortChanged(SortOption.highestMargin),
                ),
                Gap(12.w),
                BankOfferSortChip(
                  label: AppLocaleKey.lowestInstallment.tr(),
                  option: SortOption.lowestInstallment,
                  isSelected: currentSort == SortOption.lowestInstallment,
                  onTap: () => onSortChanged(SortOption.lowestInstallment),
                ),
              ],
            ),
          ),
          Gap(10.h),
        ],
      ),
    );
  }
}
