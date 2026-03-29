import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsedCarsScreen extends StatelessWidget {
  const UsedCarsScreen({super.key});

  final List<Map<String, dynamic>> usedCars = const [
    {
      'name': 'Toyota Camry 2020',
      'brand': 'Toyota',
      'image': 'assets/images/cars/toyota.png',
      'price': '85,000  ر.س       ',
      'year': '2020',
      'mileage': '45,000 كم',
      'engine': '2.5L I4',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'Nissan Altima 2021',
      'brand': 'Nissan',
      'image': 'assets/images/cars/nissan.png',
      'price': '75,000  ر.س       ',
      'year': '2021',
      'mileage': '30,000 كم',
      'engine': '2.5L I4',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'Hyundai Elantra 2019',
      'brand': 'Hyundai',
      'image': 'assets/images/cars/hyundai.png',
      'price': '55,000  ر.س       ',
      'year': '2019',
      'mileage': '60,000 كم',
      'engine': '2.0L I4',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
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
                AppLocaleKey.usedCars.tr(),
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
                      AppColor.primaryColor(context).withValues(alpha: 0.1),
                      AppColor.scaffoldColor(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                AppLocaleKey.searchForYourDreamCar.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 50.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: MagazineCardWidget(car: usedCars[index]),
                );
              }, childCount: usedCars.length),
            ),
          ),
        ],
      ),
    );
  }
}
