import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/shared/brand_card.dart';
import 'package:car/features/services/presentation/widgets/shared/model_chip.dart';
import 'package:car/features/services/presentation/widgets/shared/year_selector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ShowroomStep extends StatelessWidget {
  final List<String> brands;
  final Map<String, List<String>> models;
  final String? selectedBrand;
  final String? selectedModel;
  final int selectedYear;
  final void Function(String brand) onBrandSelected;
  final void Function(String model) onModelSelected;
  final void Function(int year) onYearChanged;

  const ShowroomStep({
    super.key,
    required this.brands,
    required this.models,
    required this.selectedBrand,
    required this.selectedModel,
    required this.selectedYear,
    required this.onBrandSelected,
    required this.onModelSelected,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.selectBrand.tr().toUpperCase(),
            style: AppTextStyle.titleMedium(context).copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              fontSize: 16.sp,
            ),
          ),
          Gap(24.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemBuilder: (_, i) => BrandCard(
              brand: brands[i],
              isSelected: selectedBrand == brands[i],
              onTap: () => onBrandSelected(brands[i]),
            ),
          ),
          if (selectedBrand != null) ...[
            Gap(40.h),
            Text(
              AppLocaleKey.selectModel.tr().toUpperCase(),
              style: AppTextStyle.titleMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                fontSize: 16.sp,
              ),
            ),
            Gap(20.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: (models[selectedBrand!] ?? [])
                  .map((m) => ModelChip(
                        model: m,
                        isSelected: selectedModel == m,
                        onTap: () => onModelSelected(m),
                      ))
                  .toList(),
            ),
            Gap(40.h),
            Text(
              AppLocaleKey.manufacturingYear.tr().toUpperCase(),
              style: AppTextStyle.titleMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                fontSize: 16.sp,
              ),
            ),
            Gap(20.h),
            YearSelector(selectedYear: selectedYear, onChanged: onYearChanged),
          ],
        ],
      ),
    );
  }
}
