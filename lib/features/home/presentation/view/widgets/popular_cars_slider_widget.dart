import 'dart:async';

import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/mini_detail_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PopularCarsSlider extends StatefulWidget {
  const PopularCarsSlider({super.key});

  @override
  State<PopularCarsSlider> createState() => _PopularCarsSliderState();
}

class _PopularCarsSliderState extends State<PopularCarsSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (!mounted) return;
      final data = context.read<HomeCubit>().state.brandCarsStatus.data;
      int fullLength = (data != null && (data as List).isNotEmpty) ? (data as List).length : 0;
      int length = fullLength > 3 ? 3 : fullLength;

      if (length > 0) {
        if (_currentPage < length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutQuart,
          );
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final double screenWidth = MediaQuery.of(context).size.width;
      final bool isTablet = screenWidth > 600;
      _pageController = PageController(
        viewportFraction: isTablet ? 0.45 : 0.85,
        initialPage: _currentPage,
      );
      _isInit = true;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToDetails(BuildContext context, Map<String, dynamic> car) {
    NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final bool isBrandSelected = state.selectedBrandId != null;
        final status = isBrandSelected ? state.brandCarsStatus : state.allPopularCarsStatus;

        List<Map<String, dynamic>> displayedCars = [];

        if (status.isSuccess && status.data != null) {
          List<GetBrandCarsDataModel> flattenedCars = [];

          if (isBrandSelected) {
            // Show only this brand's cars (limit to 3 for home preview consistent with global)
            flattenedCars = (status.data as List<GetBrandCarsDataModel>).take(3).toList();
          } else {
            // Show first 3 from each available brand
            final Map<String, List<GetBrandCarsDataModel>> allCarsMap =
                status.data as Map<String, List<GetBrandCarsDataModel>>;
            allCarsMap.forEach((brandName, cars) {
              flattenedCars.addAll(cars.take(3));
            });
          }

          if (flattenedCars.isNotEmpty) {
            displayedCars = flattenedCars
                .map(
                  (car) => {
                    'name': car.itemName,
                    'groupCode': car.groupCode.toString(),
                    'itemCode': car.itemCode.toString(),
                    'chassisNo': car.chassisNo,
                    'image': "${Constants.baseImage}${car.carImage}",
                    'extraImages': car.extraImages
                        .map((e) => "${Constants.baseImage}${e.replaceAll('../../Img/Emp/', '')}")
                        .toList(),
                    'brand': car.groupName,
                    'price': '${car.price ?? "0"}',
                    'year': car.makeYear.toString(),
                    'mileage': '${car.kilometerReading ?? "0"} كم',
                    'engine': '${car.cylinder} Cyl',
                    'video_id': 'D7O8J5vVf-M',
                    'isFavorite': false,
                    'carStatus': car.carStatus,
                    'carStatusText': car.carStatusText,
                    // Technical Details
                    'CHASSIS_NO': car.chassisNo,
                    'MOTOR_NO': car.motorNo,
                    'KILOMETER_READING': car.kilometerReading,
                    'CYLINDER': car.cylinder,
                    'POWER_HOURSE': car.powerHourse,
                    'FUEL_CAPACITY': car.fuelCapacity,
                    'SEAT_NO': car.seatNo,
                    'DOOR_NO': car.doorNo,
                    'Color': car.color,
                    'TRANSMISSION': car.transmission,
                    'MAKE_YEAR': car.makeYear,
                  },
                )
                .toList();
          }
        }

        if (status.isLoading || status.isInitial) {
          return SizedBox(
            height: 280.h,
            width: double.infinity,
            child: const Center(child: CustomLoading()),
          );
        }

        if (displayedCars.isEmpty) {
          return SizedBox(
            height: 150.h,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.car_rental_rounded,
                  size: 80.sp,
                  color: AppColor.greyColor(context).withOpacity(0.3),
                ),
                Gap(5.h),
                Text(
                  AppLocaleKey.agentNoCars.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }

        if (_currentPage >= displayedCars.length) {
          _currentPage = 0;
        }

        return SizedBox(
          height: 280.h,
          width: MediaQuery.of(context).size.width.w,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemCount: displayedCars.length > 3 ? 3 : displayedCars.length,
            itemBuilder: (context, index) {
              final car = displayedCars[index];
              final isSelected = index == _currentPage;

              return GestureDetector(
                onTap: () => _navigateToDetails(context, car),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuint,
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: isSelected ? 10.h : 20.h, // Scale effect for non-selected items
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.secondAppColor(context),
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? AppColor.primaryColor(context).withOpacity(0.15)
                            : AppColor.blackColor(context).withOpacity(0.1),
                        blurRadius: isSelected ? 20 : 10,
                        offset: isSelected ? const Offset(0, 10) : const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected
                          ? AppColor.primaryColor(context).withOpacity(0.3)
                          : AppColor.blackTextColor(context).withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      // Image Section
                      Expanded(
                        flex: 10,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Subdued background for the image
                            Container(
                              color: AppColor.blackTextColor(context).withOpacity(0.02),
                              padding: EdgeInsets.all(16.w),
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 400),
                                scale: isSelected ? 1.05 : 0.95, // Slight zoom effect
                                child: Hero(
                                  tag: 'car_image_${car['itemCode'] ?? car['name']}',
                                  child: Center(
                                    child: CustomNetworkImage(
                                      imageUrl: car['image']!,
                                      fit: BoxFit.contain,
                                      height: 100.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Bottom gradient to blend into details

                            // Favorite Icon
                            Positioned(
                              top: 16.h,
                              right: 16.w,
                              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, state) {
                                  final isFav = context.read<FavoritesCubit>().isFavorite(
                                    car['name']!,
                                  );
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<FavoritesCubit>().toggleFavorite(car);
                                    },
                                    child: CircleAvatar(
                                      radius: 16.r,
                                      backgroundColor: AppColor.blackTextColor(
                                        context,
                                      ).withOpacity(0.1),
                                      child: Icon(
                                        isFav
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        color: isFav
                                            ? Colors.redAccent
                                            : AppColor.blackTextColor(context),
                                        size: 18.w,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // "Hot Deal" Badge
                            Positioned(
                              top: 16.h,
                              left: 16.w,
                              child: Container(
                                height: 20.h,
                                width: 70.w,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor(context).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColor.primaryColor(context).withOpacity(0.5),
                                  ),
                                ),
                                child: Text(
                                  AppLocaleKey.mostRequested.tr(),
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: AppColor.blackTextColor(context),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Content Section
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 280.w, // Fixed content width for FittedBox calculation
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    car['name']!,
                                    style: AppTextStyle.titleMedium(context).copyWith(
                                      color: AppColor.blackTextColor(context),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gap(12.h),

                                  // Technical specs
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MiniDetailWidget(
                                        icon: Icons.calendar_today_outlined,
                                        label: car['year']!,
                                      ),
                                      MiniDetailWidget(
                                        icon: Icons.speed_outlined,
                                        label: car['mileage']!,
                                      ),
                                      MiniDetailWidget(
                                        icon: Icons.settings_outlined,
                                        label: car['engine']!,
                                      ),
                                    ],
                                  ),

                                  Gap(16.h),

                                  // Price
                                  Text(
                                    '${car['price']!} ${AppLocaleKey.sar.tr()}',
                                    style: AppTextStyle.titleMedium(context).copyWith(
                                      color: AppColor.primaryColor(context),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 19.sp,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                  Gap(12.h),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: CustomButton(
                                          radius: 12.r,
                                          onPressed: () => _navigateToDetails(context, car),
                                          child: Text(
                                            AppLocaleKey.orderNow.tr(),
                                            style: AppTextStyle.bodyMedium(context).copyWith(
                                              color: AppColor.whiteColor(context),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gap(12.w),
                                      Expanded(
                                        flex: 2,
                                        child: CustomButton(
                                          onPressed: () => _navigateToDetails(context, car),
                                          color: AppColor.whiteColor(context),
                                          radius: 12.r,
                                          borderColor: AppColor.blackTextColor(
                                            context,
                                          ).withOpacity(0.1),

                                          child: Text(
                                            AppLocaleKey.details.tr(),
                                            style: AppTextStyle.bodySmall(context).copyWith(
                                              color: AppColor.blackColor(context),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
      },
    );
  }
}
