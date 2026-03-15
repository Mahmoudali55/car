import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 5.h),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        itemBuilder: (context, index) {
          return FadeInRight(
            delay: Duration(milliseconds: index * 100),
            child: Column(
              children: [
                Container(
                  width: 75.w,
                  height: 75.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.primaryColor(context).withOpacity(0.05),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: AppColor.primaryColor(context).withOpacity(0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    categories[index]['image']!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.directions_car_rounded, color: AppColor.primaryColor(context)),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  categories[index]['name'] as String,
                  style: AppTextStyle.bodySmall(
                    context,
                    color: AppColor.whiteColor(context),
                  ).copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
