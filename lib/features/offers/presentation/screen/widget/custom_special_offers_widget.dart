import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/offers/presentation/screen/widget/filter_chips_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomSpecialOffersWidget extends StatelessWidget {
  const CustomSpecialOffersWidget({
    super.key,
    required int selectedFilterIndex,
    required List<String> filters,
    required List<Map<String, dynamic>> offers,
  }) : _selectedFilterIndex = selectedFilterIndex,
       _filters = filters,
       _offers = offers;

  final int _selectedFilterIndex;
  final List<String> _filters;
  final List<Map<String, dynamic>> _offers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChipsWidget(selectedFilterIndex: _selectedFilterIndex, filters: _filters),
          Gap(24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocaleKey.specialOffers.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 20.sp,
                  ),
                ),
                Text(
                  '${_offers.length} ${AppLocaleKey.offers.tr()}',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.primaryColor(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
