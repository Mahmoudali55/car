import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/filter_widgets.dart';
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
      AppLocaleKey.mercedes,
      AppLocaleKey.bmw,
      AppLocaleKey.toyota,
      AppLocaleKey.tesla,
      AppLocaleKey.audi,
      AppLocaleKey.ford,
      AppLocaleKey.hyundai,
      AppLocaleKey.kia,
      AppLocaleKey.mazda,
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
      AppLocaleKey.hatchback,
      AppLocaleKey.sedan,
      AppLocaleKey.suv,
      AppLocaleKey.family,
      AppLocaleKey.commercial,
      AppLocaleKey.coupe,
    ],
    AppLocaleKey.countryOfOrigin: [
      AppLocaleKey.japan,
      AppLocaleKey.china,
      AppLocaleKey.korea,
      AppLocaleKey.usa,
      AppLocaleKey.europe,
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
              FilterSection(
                title: AppLocaleKey.brands.tr(),
                child: _buildChipsGroup(AppLocaleKey.brands),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.manufacturingYear.tr(),
                child: FilterRangeSlider(
                  values: _yearRange,
                  min: 1990,
                  max: 2025,
                  onChanged: (values) => setState(() => _yearRange = values),
                ),
              ),

              Gap(24.h),
              FilterCheckboxTile(
                title: AppLocaleKey.testDrive.tr(),
                value: _isTestDriveAvailable,
                onChanged: (v) => setState(() => _isTestDriveAvailable = v!),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.status.tr(),
                child: _buildChipsGroup(AppLocaleKey.status),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.price.tr(),
                child: FilterRangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 2000000,
                  onChanged: (values) => setState(() => _priceRange = values),
                  isPrice: true,
                ),
              ),

              Gap(24.h),
              FilterCheckboxTile(
                title: AppLocaleKey.taxInclusive.tr(),
                value: _isTaxInclusive,
                onChanged: (v) => setState(() => _isTaxInclusive = v!),
              ),
              FilterCheckboxTile(
                title: AppLocaleKey.discount.tr(),
                value: _isDiscountApplied,
                onChanged: (v) => setState(() => _isDiscountApplied = v!),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.engineSystem.tr(),
                child: _buildChipsGroup(AppLocaleKey.engineSystem),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.driveType.tr(),
                child: _buildChipsGroup(AppLocaleKey.driveType),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.bodyType.tr(),
                child: _buildChipsGroup(AppLocaleKey.bodyType),
              ),

              Gap(24.h),
              FilterSection(
                title: AppLocaleKey.countryOfOrigin.tr(),
                child: _buildChipsGroup(AppLocaleKey.countryOfOrigin),
              ),
            ],
          ),

          FilterApplyButton(
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsGroup(String groupKey) {
    return FilterChipsGroup(
      groupKey: groupKey,
      items: _selectionGroups[groupKey]!,
      selectedItem: _selectedItems[groupKey],
      onSelected: (item) {
        setState(() {
          if (item == null) {
            _selectedItems.remove(groupKey);
          } else {
            _selectedItems[groupKey] = item;
          }
        });
      },
    );
  }
}
