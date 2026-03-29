import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _yearRange = const RangeValues(2000, 2024);
  RangeValues _priceRange = const RangeValues(10000, 1000000);
  bool _isTaxInclusive = false;
  bool _isDiscountApplied = false;
  bool _isTestDriveAvailable = false;

  final Map<String, List<String>> _selectionGroups = {
    AppLocaleKey.brands: [
      'mercedes',
      'bmw',
      'toyota',
      'tesla',
      'audi',
      'ford',
      'hyundai',
      'kia',
      'mazda',
    ],
    AppLocaleKey.status: [
      AppLocaleKey.available,
      AppLocaleKey.unavailable,
      AppLocaleKey.availableOnRequest,
    ],
    AppLocaleKey.engineSystem: [
      AppLocaleKey.petrol,
      AppLocaleKey.diesel,
      AppLocaleKey.hybrid,
      AppLocaleKey.electric,
    ],
    AppLocaleKey.driveType: [
      AppLocaleKey.normal,
      AppLocaleKey.sport,
      AppLocaleKey.sand,
      AppLocaleKey.snow,
      AppLocaleKey.mud,
    ],
    AppLocaleKey.bodyType: [
      'hatchback',
      'sedan',
      'suv',
      AppLocaleKey.family,
      AppLocaleKey.commercial,
      'coupe',
    ],
    AppLocaleKey.countryOfOrigin: [
      AppLocaleKey.japan,
      AppLocaleKey.china,
      AppLocaleKey.korea,
      AppLocaleKey.usa,
      AppLocaleKey.europe,
    ],
    AppLocaleKey.condition: [
      AppLocaleKey.newCar,
      AppLocaleKey.usedCar,
    ],
  };

  final Map<String, String> _selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close_rounded, color: AppColor.blackTextColor(context), size: 24.sp),
        ),
        title: Text(
          AppLocaleKey.filter.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _selectedItems.clear()),
            child: Text(
              AppLocaleKey.clearAll.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.primaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap(10.w),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 120.h),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildSectionTitle(AppLocaleKey.brands.tr()),
              _buildChipsGroup(AppLocaleKey.brands),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.condition.tr()),
              _buildChipsGroup(AppLocaleKey.condition),


              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.manufacturingYear.tr()),
              _buildRangeSlider(
                _yearRange,
                1990,
                2025,
                (values) => setState(() => _yearRange = values),
              ),

              Gap(24.h),
              _buildCheckboxTile(
                AppLocaleKey.testDrive.tr(),
                _isTestDriveAvailable,
                (v) => setState(() => _isTestDriveAvailable = v!),
              ),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.status.tr()),
              _buildChipsGroup(AppLocaleKey.status),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.price.tr()),
              _buildRangeSlider(
                _priceRange,
                0,
                2000000,
                (values) => setState(() => _priceRange = values),
                isPrice: true,
              ),

              Gap(24.h),
              _buildCheckboxTile(
                AppLocaleKey.taxInclusive.tr(),
                _isTaxInclusive,
                (v) => setState(() => _isTaxInclusive = v!),
              ),
              _buildCheckboxTile(
                AppLocaleKey.discount.tr(),
                _isDiscountApplied,
                (v) => setState(() => _isDiscountApplied = v!),
              ),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.engineSystem.tr()),
              _buildChipsGroup(AppLocaleKey.engineSystem),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.driveType.tr()),
              _buildChipsGroup(AppLocaleKey.driveType),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.bodyType.tr()),
              _buildChipsGroup(AppLocaleKey.bodyType),

              Gap(24.h),
              _buildSectionTitle(AppLocaleKey.countryOfOrigin.tr()),
              _buildChipsGroup(AppLocaleKey.countryOfOrigin),
            ],
          ),

          // Apply Button
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 30.h,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor(context),
                minimumSize: Size(double.infinity, 56.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 8,
                shadowColor: AppColor.primaryColor(
                  context,
                ).withValues(alpha: 0.4),
              ),
              child: Text(
                AppLocaleKey.applyFilter.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        title,
        style: AppTextStyle.bodyMedium(context).copyWith(
          color: AppColor.blackTextColor(context),
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildChipsGroup(String groupKey) {
    final items = _selectionGroups[groupKey]!;
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: items.map((item) {
        final isSelected = _selectedItems[groupKey] == item;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedItems.remove(groupKey);
              } else {
                _selectedItems[groupKey] = item;
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.primaryColor(context)
                  : AppColor.secondAppColor(context),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColor.blackTextColor(context).withValues(alpha: 0.1),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColor.primaryColor(
                          context,
                        ).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              item.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: isSelected ? AppColor.whiteColor(context) : AppColor.blackTextColor(context).withValues(alpha: 0.70),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRangeSlider(
    RangeValues values,
    double min,
    double max,
    ValueChanged<RangeValues> onChanged, {
    bool isPrice = false,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isPrice
                  ? '${values.start.toInt().toString()} ${AppLocaleKey.aed.tr()}'
                  : values.start.toInt().toString(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.primaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isPrice
                  ? '${values.end.toInt().toString()} ${AppLocaleKey.aed.tr()}'
                  : values.end.toInt().toString(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.primaryColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: isPrice ? 100 : (max - min).toInt(),
          activeColor: AppColor.primaryColor(context),
          inactiveColor: AppColor.blackTextColor(context).withValues(alpha: 0.1),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCheckboxTile(
    String title,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: AppColor.blackTextColor(context).withValues(alpha: 0.24)),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.70)),
        ),
        activeColor: AppColor.primaryColor(context),
        checkColor: AppColor.whiteColor(context),
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.trailing,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
