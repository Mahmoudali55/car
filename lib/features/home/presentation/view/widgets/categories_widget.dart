import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final categories = [
    {'name': AppLocaleKey.mercedes.tr(), 'image': 'assets/images/cars/mercedes-benz.png'},
    {'name': AppLocaleKey.bmw.tr(), 'image': 'assets/images/cars/bmw.png'},
    {'name': AppLocaleKey.toyota.tr(), 'image': 'assets/images/cars/toyota.png'},
    {'name': AppLocaleKey.tesla.tr(), 'image': 'assets/images/cars/tesla.png'},
    {'name': AppLocaleKey.audi.tr(), 'image': 'assets/images/cars/audi.png'},
    {'name': AppLocaleKey.nissan.tr(), 'image': 'assets/images/cars/nissan.png'},
    {'name': AppLocaleKey.ford.tr(), 'image': 'assets/images/cars/ford.png'},
    {'name': AppLocaleKey.hyundai.tr(), 'image': 'assets/images/cars/hyundai.png'},
    {'name': AppLocaleKey.volkswagen.tr(), 'image': 'assets/images/cars/volkswagen.png'},
    {'name': AppLocaleKey.kia.tr(), 'image': 'assets/images/cars/kia.png'},
    {'name': AppLocaleKey.lamborghini.tr(), 'image': 'assets/images/cars/lamborghini.png'},
    {'name': AppLocaleKey.porsche.tr(), 'image': 'assets/images/cars/porsche.png'},
    {'name': AppLocaleKey.mclaren.tr(), 'image': 'assets/images/cars/mclaren.png'},
    {'name': AppLocaleKey.bugatti.tr(), 'image': 'assets/images/cars/bugatti.png'},
    {'name': AppLocaleKey.jaguar.tr(), 'image': 'assets/images/cars/jaguar.png'},
    {'name': AppLocaleKey.mazda.tr(), 'image': 'assets/images/cars/mazda.png'},
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet || context.isDesktop;
    return SizedBox(
      height: isTablet ? 200.h : 140.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => Gap(16.w),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;

          return FadeInRight(
            delay: Duration(milliseconds: index * 50),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: AnimatedScale(
                scale: isSelected ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: 90.w,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              AppColor.primaryColor(context),
                              const Color(0xff0047BB), // Deep royal blue
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : AppColor.secondAppColor(context),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColor.whiteColor(context).withOpacity(0.3)
                          : AppColor.blackTextColor(context).withOpacity(0.08),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? AppColor.primaryColor(context).withOpacity(0.4)
                            : Colors.black.withOpacity(0.03),
                        blurRadius: isSelected ? 20 : 10,
                        offset: isSelected ? const Offset(0, 8) : const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.2)
                              : AppColor.blackTextColor(context).withOpacity(0.03),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          categories[index]['image']!,
                          width: 32.w,
                          height: 32.w,
                          fit: BoxFit.contain,
                          color: isSelected ? Colors.white : null,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.directions_car_rounded,
                            color: isSelected ? Colors.white : AppColor.primaryColor(context),
                            size: 24.w,
                          ),
                        ),
                      ),
                      Gap(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            categories[index]['name'] as String,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColor.blackTextColor(context).withOpacity(0.8),
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                              fontSize: 11.sp,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
