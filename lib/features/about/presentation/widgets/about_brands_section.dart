import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AboutBrandsSection extends StatelessWidget {
  const AboutBrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final brands = [
      'Toyota',
      'Ford',
      'Nissan',
      'Hyundai',
      'Lincoln',
      'Chery',
      'BAIC',
      'MG',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.authorizedDistributor.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        Gap(16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: brands.map((brand) => _BrandChip(brand: brand)).toList(),
        ),
      ],
    );
  }
}

class _BrandChip extends StatelessWidget {
  final String brand;

  const _BrandChip({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
      ),
      child: Text(
        brand,
        style: TextStyle(
          color: AppColor.blackTextColor(context),
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
