import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
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
    {
      'name': AppLocaleKey.mercedes.tr(),
      'image': 'assets/images/cars/mercedes-benz.png',
    },
    {'name': AppLocaleKey.bmw.tr(), 'image': 'assets/images/cars/bmw.png'},
    {
      'name': AppLocaleKey.toyota.tr(),
      'image': 'assets/images/cars/toyota.png',
    },
    {'name': AppLocaleKey.tesla.tr(), 'image': 'assets/images/cars/tesla.png'},
    {'name': AppLocaleKey.audi.tr(), 'image': 'assets/images/cars/audi.png'},
    {
      'name': AppLocaleKey.nissan.tr(),
      'image': 'assets/images/cars/nissan.png',
    },
    {'name': AppLocaleKey.ford.tr(), 'image': 'assets/images/cars/ford.png'},
    {
      'name': AppLocaleKey.hyundai.tr(),
      'image': 'assets/images/cars/hyundai.png',
    },
    {
      'name': AppLocaleKey.volkswagen.tr(),
      'image': 'assets/images/cars/volkswagen.png',
    },
    {'name': AppLocaleKey.kia.tr(), 'image': 'assets/images/cars/kia.png'},
    {
      'name': AppLocaleKey.lamborghini.tr(),
      'image': 'assets/images/cars/lamborghini.png',
    },
    {
      'name': AppLocaleKey.porsche.tr(),
      'image': 'assets/images/cars/porsche.png',
    },
    {
      'name': AppLocaleKey.mclaren.tr(),
      'image': 'assets/images/cars/mclaren.png',
    },
    {
      'name': AppLocaleKey.bugatti.tr(),
      'image': 'assets/images/cars/bugatti.png',
    },
    {
      'name': AppLocaleKey.jaguar.tr(),
      'image': 'assets/images/cars/jaguar.png',
    },
    {'name': AppLocaleKey.mazda.tr(), 'image': 'assets/images/cars/mazda.png'},
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => Gap(12.w),
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
                scale: isSelected ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 8.h),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              AppColor.primaryColor(context),
                              const Color(0xff0047BB), // Deep blue for depth
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected
                        ? null
                        : AppColor.secondAppColor(
                            context,
                          ).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColor.whiteColor(context).withValues(alpha: 0.2)
                          : AppColor.whiteColor(
                              context,
                            ).withValues(alpha: 0.05),
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColor.primaryColor(
                                context,
                              ).withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor(
                            context,
                          ).withValues(alpha: isSelected ? 0.2 : 1.0),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          categories[index]['image']!,
                          width: 22.w,
                          height: 22.w,
                          fit: BoxFit.contain,
                          color: isSelected
                              ? AppColor.whiteColor(context)
                              : null,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.directions_car_rounded,
                            color: isSelected
                                ? AppColor.whiteColor(context)
                                : AppColor.primaryColor(context),
                            size: 18.w,
                          ),
                        ),
                      ),
                      Gap(10.w),
                      Text(
                        categories[index]['name'] as String,
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: isSelected
                              ? AppColor.whiteColor(context)
                              : AppColor.whiteColor(
                                  context,
                                ).withValues(alpha: 0.7),
                          fontWeight: isSelected
                              ? FontWeight.w900
                              : FontWeight.w600,
                          fontSize: 13.sp,
                          letterSpacing: 0.5,
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
