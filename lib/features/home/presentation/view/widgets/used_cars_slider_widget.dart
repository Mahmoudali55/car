import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UsedCarsSliderWidget extends StatelessWidget {
  const UsedCarsSliderWidget({super.key});

  final List<Map<String, dynamic>> usedCars = const [
    {
      'name': 'Toyota Camry 2020',
      'brand': 'Toyota',
      'image': 'assets/images/cars/toyota.png',
      'price': '85,000 د.إ',
      'year': '2020',
      'mileage': '45,000 كم',
      'engine': '2.5L I4',
      'isFavorite': false,
    },
    {
      'name': 'Nissan Altima 2021',
      'brand': 'Nissan',
      'image': 'assets/images/cars/nissan.png',
      'price': '75,000 د.إ',
      'year': '2021',
      'mileage': '30,000 كم',
      'engine': '2.5L I4',
      'isFavorite': false,
    },
    {
      'name': 'Hyundai Elantra 2019',
      'brand': 'Hyundai',
      'image': 'assets/images/cars/hyundai.png',
      'price': '55,000 د.إ',
      'year': '2019',
      'mileage': '60,000 كم',
      'engine': '2.0L I4',
      'isFavorite': false,
    },
  ];

  void _navigateToDetails(BuildContext context, Map<String, dynamic> car) {
    NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: usedCars.length,
        separatorBuilder: (context, index) => Gap(16.w),
        itemBuilder: (context, index) {
          final car = usedCars[index];
          return GestureDetector(
            onTap: () => _navigateToDetails(context, car),
            child: Container(
              width: 180.w,
              decoration: BoxDecoration(
                color: AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          color: Colors.white.withValues(alpha: 0.02),
                          child: Hero(
                            tag: 'used_car_${car['name']}',
                            child: Image.asset(car['image']!, fit: BoxFit.contain),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: BlocBuilder<FavoritesCubit, FavoritesState>(
                            builder: (context, state) {
                              final isFav = context.read<FavoritesCubit>().isFavorite(car['name']!);
                              return GestureDetector(
                                onTap: () => context.read<FavoritesCubit>().toggleFavorite(car),
                                child: CircleAvatar(
                                  radius: 14.r,
                                  backgroundColor: Colors.black.withValues(alpha: 0.3),
                                  child: Icon(
                                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                    color: isFav ? Colors.redAccent : Colors.white,
                                    size: 16.w,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car['name']!,
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.speed_rounded,
                                size: 12.w,
                                color: AppColor.primaryColor(context),
                              ),
                              Gap(4.w),
                              Text(
                                car['mileage']!,
                                style: AppTextStyle.bodySmall(context).copyWith(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            car['price']!,
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.w900,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
