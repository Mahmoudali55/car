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

  int _selectedIndex = 0; // Allow user to visually select a category

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColor.primaryColor(context) 
                      : AppColor.secondAppColor(context),
                  borderRadius: BorderRadius.circular(30.r), // Ultra rounded / Pill shape
                  border: Border.all(
                    color: isSelected
                        ? AppColor.primaryColor(context)
                        : Colors.white.withOpacity(0.08),
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColor.primaryColor(context).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      categories[index]['image']!,
                      width: 28.w,
                      height: 28.w,
                      fit: BoxFit.contain,
                      color: isSelected ? Colors.white : null, // Assuming logos can gracefully switch to white if they have transparency. If not, using null keeps original logo color.
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.directions_car_rounded, 
                               color: isSelected ? Colors.white : AppColor.primaryColor(context), 
                               size: 24.w),
                    ),
                    Gap(10.w),
                    Text(
                      categories[index]['name'] as String,
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
