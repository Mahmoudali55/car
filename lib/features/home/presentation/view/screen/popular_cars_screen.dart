import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularCarsScreen extends StatelessWidget {
  const PopularCarsScreen({super.key});

  final List<Map<String, dynamic>> popularCars = const [
    {
      'name': 'Ferrari SF90',
      'image': 'assets/images/cars/mercedes-benz.png',
      'brand': 'Ferrari',
      'price': '1,200,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Lamborghini Revuelto',
      'brand': 'Lamborghini',
      'image': 'assets/images/cars/lamborghini.png',
      'price': '2,500,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '6.5L V12',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Porsche 911 GT3',
      'brand': 'Porsche',
      'image': 'assets/images/cars/porsche.png',
      'price': '950,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L F6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Mercedes G63 AMG',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': '850,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'McLaren 750S',
      'brand': 'McLaren',
      'image': 'assets/images/cars/mercedes-benz.png', // Temporary fallback
      'price': '1,100,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Custom Header
              SliverAppBar(
                expandedHeight: 120.h,
                floating: true,
                pinned: true,
                backgroundColor: AppColor.scaffoldColor(context),
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColor.blackTextColor(context),
                    size: 20.sp,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    AppLocaleKey.popularCars.tr(),
                    style: AppTextStyle.titleMedium(context).copyWith(
                      color: AppColor.blackTextColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColor(context).withOpacity(0.1),
                          AppColor.scaffoldColor(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Search/Filter Placeholder or Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    AppLocaleKey.mostPopularAndActiveCars.tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blackTextColor(context).withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Magazine-Style List
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 50.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: MagazineCardWidget(car: popularCars[index]),
                    );
                  }, childCount: popularCars.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
