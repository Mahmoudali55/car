import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CityDropdown extends StatelessWidget {
  final String? selectedCity;
  final ValueChanged<String> onChanged;

  const CityDropdown({super.key, required this.selectedCity, required this.onChanged});

  static List<String> cities(BuildContext context) => [
    AppLocaleKey.cityRiyadh.tr(),
    AppLocaleKey.cityJeddah.tr(),
    AppLocaleKey.cityMecca.tr(),
    AppLocaleKey.cityMedina.tr(),
    AppLocaleKey.cityDammam.tr(),
    AppLocaleKey.cityKhobar.tr(),
    AppLocaleKey.cityDhahran.tr(),
    AppLocaleKey.cityAbha.tr(),
    AppLocaleKey.cityTabuk.tr(),
    AppLocaleKey.cityBuraidah.tr(),
    AppLocaleKey.cityHail.tr(),
    AppLocaleKey.cityNajran.tr(),
    AppLocaleKey.cityJazan.tr(),
    AppLocaleKey.cityTaif.tr(),
    AppLocaleKey.cityJubail.tr(),
  ];

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Text(
              AppLocaleKey.agentCity.tr(),
              style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(16.h),
            Divider(height: 1, color: AppColor.dividerColor(context)),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                itemCount: cities(context).length,
                separatorBuilder: (_, __) => Gap(12.h),
                itemBuilder: (ctx, index) {
                  final city = cities(context)[index];
                  final isSelected = city == selectedCity;
                  return GestureDetector(
                    onTap: () {
                      onChanged(city);
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primaryColor(context).withValues(alpha: 0.1)
                            : AppColor.cardColor(context),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primaryColor(context)
                              : AppColor.borderColor(context),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColor.primaryColor(context),
                              size: 20.sp,
                            )
                          else
                            const SizedBox.shrink(),
                          Expanded(
                            child: Text(
                              city,
                              style: AppTextStyle.bodyMedium(context).copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected
                                    ? AppColor.primaryColor(context)
                                    : AppColor.blackTextColor(context),
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.greyColor(context)),
            Text(
              selectedCity ?? AppLocaleKey.agentCity.tr(),
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: selectedCity == null
                    ? AppColor.hintColor(context)
                    : AppColor.blackTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
