import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PopularCarsScreen extends StatelessWidget {
  const PopularCarsScreen({super.key});

  final List<Map<String, dynamic>> popularCars = const [
    {
      'name': 'Ferrari SF90',
      'image': 'assets/images/cars/mercedes-benz.png', // Temporary fallback
      'brand': 'Ferrari',
      'price': '1,200,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Lamborghini Revuelto',
      'brand': 'Lamborghini',
      'image': 'assets/images/cars/lamborghini.png',
      'price': '2,500,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '6.5L V12',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Porsche 911 GT3',
      'brand': 'Porsche',
      'image': 'assets/images/cars/porsche.png',
      'price': '950,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L F6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Mercedes G63 AMG',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': '850,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'McLaren 750S',
      'brand': 'McLaren',
      'image': 'assets/images/cars/mercedes-benz.png', // Temporary fallback
      'price': '1,100,000 د.إ',
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
      body: CustomScrollView(
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
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20.sp),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocaleKey.popularCars.tr(),
                style: AppTextStyle.titleMedium(context).copyWith(
                  color: Colors.white,
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

          // Search/Filter Placeholder or Info
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                "اكتشف السيارات الأكثر طلباً وفعالية في السوق",
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
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
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: _buildMagazineCard(context, popularCars[index]),
                  );
                },
                childCount: popularCars.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMagazineCard(BuildContext context, Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () => NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car),
      child: Container(
        height: 380.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 1. Background Typography (Faded Brand Name)
            Positioned(
              left: -20.w,
              top: 40.h,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  car['brand'].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.03),
                    fontSize: 80.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 10,
                  ),
                ),
              ),
            ),

            // 2. Vertical Layout Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Action Bar inside Card
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor(context).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          car['brand'],
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColor.primaryColor(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context.read<FavoritesCubit>().isFavorite(car['name']);
                          return GestureDetector(
                            onTap: () => context.read<FavoritesCubit>().toggleFavorite(car),
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.black.withValues(alpha: 0.3),
                              child: Icon(
                                isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                                color: isFav ? Colors.redAccent : Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // 3. Featured Car Image (Floating effect)
                Expanded(
                  child: Center(
                    child: Transform.scale(
                      scale: 1.1,
                      child: Hero(
                        tag: 'popular_car_${car['name']}',
                        child: Image.asset(car['image'], fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),

                // 4. Glassmorphic Footer
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              car['name'],
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 22.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            car['price'],
                            style: AppTextStyle.titleMedium(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      Gap(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSpecBadge(context, Icons.calendar_today_rounded, car['year']),
                          _buildSpecBadge(context, Icons.speed_rounded, car['mileage']),
                          _buildSpecBadge(context, Icons.electric_bolt_rounded, car['engine']),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecBadge(BuildContext context, IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white54, size: 14.sp),
          Gap(6.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
