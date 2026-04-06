import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BrandSelectorWidget extends StatelessWidget {
  final BrandModel? selectedBrand;
  final Function(BrandModel?) onBrandSelected;

  const BrandSelectorWidget({
    super.key,
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  @override
  Widget build(BuildContext context) {
    final list = BrandModel.brands;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'search_for_brand'.tr(), // Locale key from app_locale_keys
            style: AppTextStyle.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(16.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (context, index) => Gap(16.w),
            itemBuilder: (context, index) {
              final brand = list[index];
              final isAll = brand.name == 'All';
              final isSelected = selectedBrand?.name == brand.name || (selectedBrand == null && isAll);

              return FadeInRight(
                duration: Duration(milliseconds: 200 + (index * 100)),
                child: GestureDetector(
                  onTap: () => onBrandSelected(isAll ? null : brand),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColor.primaryColor(context)
                              : AppColor.secondAppColor(context),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColor.primaryColor(context).withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : AppColor.blackTextColor(context).withOpacity(0.1),
                          ),
                        ),
                        child: Center(
                          child: isAll
                              ? Icon(
                                  Icons.grid_view_rounded,
                                  color: isSelected
                                      ? AppColor.whiteColor(context)
                                      : AppColor.blackTextColor(context),
                                )
                              : Image.asset(
                                  brand.logo,
                                  width: 40.w,
                                  height: 40.w,
                                  fit: BoxFit.contain,
                                  // Apply white filter if selected and logo is dark
                                  // Most brand logos are dark so they look good on white/secondAppColor
                                  // but need to be visible on primaryColor
                                  color: isSelected ? AppColor.whiteColor(context) : null,
                                ),
                        ),
                      ),
                      Gap(8.h),
                      Text(
                        brand.localeKey.tr(),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? AppColor.primaryColor(context)
                              : AppColor.blackTextColor(context).withOpacity(0.6),
                          fontSize: 10.sp,
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
    );
  }
}
