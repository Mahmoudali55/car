import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OffersGridWidget extends StatelessWidget {
  const OffersGridWidget({super.key});

  final List<Map<String, dynamic>> _offers = const [
    {
      'name': 'G63 AMG 2024',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': '850,000  ر.س       ',
      'oldPrice': '1,000,000  ر.س       ',
      'installments': '1,166 ر.س / شهر',
      'cashPrice': '850,000',
      'discount': '15%',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'M5 Competition',
      'brand': 'BMW',
      'image': 'assets/images/cars/bmw.png',
      'price': '440,000  ر.س       ',
      'oldPrice': '520,000  ر.س       ',
      'installments': '1,166 ر.س / شهر',
      'cashPrice': '440,000',
      'discount': '10%',
      'year': '2023',
      'mileage': '5,000 كم',
      'engine': '4.4L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
      'is_financing_available': false,
    },
    {
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'image': 'assets/images/cars/toyota.png',
      'price': '330,000  ر.س       ',
      'oldPrice': '350,000  ر.س       ',
      'installments': '1,166 ر.س / شهر',
      'cashPrice': '330,000',
      'discount': '5%',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'image': 'assets/images/cars/tesla.png',
      'price': '450,000  ر.س       ',
      'oldPrice': '480,000  ر.س       ',
      'installments': '1,166 ر.س / شهر',
      'cashPrice': '450,000',
      'discount': '7%',
      'year': '2024',
      'mileage': '0 كم',
      'engine': 'Electric',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet || context.isDesktop;
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _offers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        childAspectRatio: isTablet ? 0.75 : 0.63,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) {
        final car = _offers[index];
        return GestureDetector(
          onTap: () {
            NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.secondAppColor(context),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Background Brand Overlay (Subtle)
                Positioned(
                  right: -10,
                  top: 20,
                  child: Opacity(
                    opacity: 0.03,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        car['brand'] ?? '',
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Image Area
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColor.blackTextColor(context).withOpacity(0.05),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Hero(
                              tag: 'car_image_${car['name']}',
                              child: Center(
                                child: Image.asset(car['image'], height: 60.h, fit: BoxFit.contain),
                              ),
                            ),
                            // Favorite Button
                            Positioned(
                              top: 12.h,
                              right: 12.w,
                              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, state) {
                                  final isFav = context.read<FavoritesCubit>().isFavorite(
                                    car['name']!,
                                  );
                                  return GestureDetector(
                                    onTap: () => context.read<FavoritesCubit>().toggleFavorite(car),
                                    child: Container(
                                      padding: EdgeInsets.all(6.w),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isFav
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        color: isFav
                                            ? Colors.redAccent
                                            : AppColor.blackTextColor(context),
                                        size: 14.sp,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Details Area
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['brand'],
                              style: TextStyle(
                                color: AppColor.primaryColor(context),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              car['name'],
                              style: AppTextStyle.titleSmall(context).copyWith(
                                color: AppColor.blackTextColor(context),
                                fontWeight: FontWeight.w900,
                                fontSize: 13.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            // Specs
                            Row(
                              children: [
                                Icon(
                                  Icons.speed_outlined,
                                  color: AppColor.blackTextColor(context).withOpacity(0.24),
                                  size: 12.sp,
                                ),
                                Gap(4.w),
                                Expanded(
                                  child: Text(
                                    car['mileage'],
                                    style: TextStyle(
                                      color: AppColor.blackTextColor(
                                        context,
                                      ).withOpacity(0.38),
                                      fontSize: 9.sp,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                Gap(4.w),
                                Icon(
                                  Icons.bolt_rounded,
                                  color: AppColor.blackTextColor(context).withOpacity(0.24),
                                  size: 12.sp,
                                ),
                                Gap(2.w),
                                Text(
                                  (car['engine'] as String).split(' ').last,
                                  style: TextStyle(
                                    color: AppColor.blackTextColor(context).withOpacity(0.38),
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ],
                            ),
                            Gap(12.h),
                            // Price and Action
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        car['oldPrice'],
                                        style: TextStyle(
                                          color: AppColor.blackTextColor(
                                            context,
                                          ).withOpacity(0.24),
                                          fontSize: 9.sp,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Gap(4.h),
                                      Text(
                                        car['price'],
                                        style: TextStyle(
                                          color: AppColor.blackTextColor(context),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor(context),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: AppColor.whiteColor(context),
                                    size: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Gap(12.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Discount Badge (Pill Style)
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "${car['discount']} OFF",
                      style: TextStyle(
                        color: AppColor.whiteColor(context),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
