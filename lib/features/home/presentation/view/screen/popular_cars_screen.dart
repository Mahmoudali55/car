import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PopularCarsScreen extends StatelessWidget {
  const PopularCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final status = state.allPopularCarsStatus;
        final bool isBrandSelected = state.selectedBrandId != null;

        // Start with the full map
        Map<String, List<GetBrandCarsDataModel>> allCarsMap = status.data ?? {};

        // If a brand is selected, we filter the map
        if (isBrandSelected) {
          String brandName = 'Unknown';
          final brands = state.carsModelsStatus.data ?? [];
          for (final b in brands) {
            if (b.groupCode == state.selectedBrandId) {
              brandName = b.groupName;
              break;
            }
          }
          final brandCars = allCarsMap[brandName] ?? [];
          allCarsMap = {brandName: brandCars};
        }

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
                        isBrandSelected && allCarsMap.isNotEmpty
                            ? (allCarsMap.keys.first)
                            : AppLocaleKey.popularCars.tr(),
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

                  if (status.isLoading)
                    const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
                  else if (allCarsMap.isEmpty ||
                      (allCarsMap.length == 1 && allCarsMap.values.first.isEmpty))
                    SliverFillRemaining(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.car_rental_rounded,
                                size: 80.sp,
                                color: AppColor.greyColor(context).withOpacity(0.3),
                              ),
                              Gap(20.h),
                              Text(
                                isBrandSelected
                                    ? AppLocaleKey.agentNoCarsAvailable.tr()
                                    : AppLocaleKey.agentNoCars.tr(),
                                textAlign: TextAlign.center,
                                style: AppTextStyle.titleMedium(context).copyWith(
                                  color: AppColor.greyColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    ...allCarsMap.entries.map((entry) {
                      final brandName = entry.key;
                      final cars = entry.value;
                      if (cars.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

                      return SliverMainAxisGroup(
                        slivers: [
                          if (!isBrandSelected) // Only show headers if showing multiple brands
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 15.h),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 4.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor(context),
                                        borderRadius: BorderRadius.circular(2.r),
                                      ),
                                    ),
                                    Gap(12.w),
                                    Text(
                                      brandName.toUpperCase(),
                                      style: AppTextStyle.titleMedium(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.w900, letterSpacing: 2),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${cars.length} ${AppLocaleKey.cars.tr()}',
                                      style: AppTextStyle.bodySmall(
                                        context,
                                      ).copyWith(color: AppColor.greyColor(context)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: isBrandSelected ? 20.h : 0,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((context, index) {
                                final car = cars[index];
                                final mappedCar = {
                                  'name': car.itemName,
                                  'groupCode': car.groupCode.toString(),
                                  'itemCode': car.itemCode.toString(),
                                  'image': "${Constants.baseImage}${car.carImage}",
                                  'extraImages': car.extraImages
                                      .map(
                                        (e) =>
                                            "${Constants.baseImage}${e.replaceAll('../../Img/Emp/', '')}",
                                      )
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
                                };
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 24.h),
                                  child: MagazineCardWidget(car: mappedCar),
                                );
                              }, childCount: cars.length),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  SliverToBoxAdapter(child: Gap(100.h)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
