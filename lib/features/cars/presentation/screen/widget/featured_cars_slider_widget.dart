import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturedCarsSliderWidget extends StatefulWidget {
  final List<Map<String, String>> featuredCars;
  const FeaturedCarsSliderWidget({super.key, required this.featuredCars});

  @override
  State<FeaturedCarsSliderWidget> createState() => _FeaturedCarsSliderWidgetState();
}

class _FeaturedCarsSliderWidgetState extends State<FeaturedCarsSliderWidget> {
  final PageController _pageController = PageController();
  int _currentSliderIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentSliderIndex = index),
            itemCount: widget.featuredCars.length,
            itemBuilder: (context, index) {
              final car = widget.featuredCars[index];
              return GestureDetector(
                onTap: () {
                  NavigatorMethods.pushNamed(
                    context,
                    RoutesName.carDetailsScreen,
                    arguments: {
                      'car': car,
                      'heroTag': 'featured_car_image_${car['itemCode'] ?? car['name']}',
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColor.secondAppColor(context),
                    borderRadius: BorderRadius.circular(24.r),
                    image: DecorationImage(
                      image: car['image'].toString().startsWith('http')
                          ? NetworkImage(car['image']!)
                          : AssetImage(car['image']!) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),

                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                AppLocaleKey.specialOffersCars.tr(),
                                style: AppTextStyle.bodySmall(context).copyWith(
                                  color: AppColor.whiteColor(context),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Gap(8.h),
                            Text(
                              car['name']!,
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: AppColor.blackTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(4.h),
                            Text(
                              car['price']!,
                              style: AppTextStyle.bodyMedium(context).copyWith(
                                color: AppColor.primaryColor(context),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            if (car['installments'] != null)
                              Text(
                                car['installments']!,
                                style: AppTextStyle.bodySmall(context).copyWith(
                                  color: AppColor.primaryColor(context).withOpacity(0.8),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Gap(12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.featuredCars.length,
            (index) => Container(
              margin: EdgeInsets.only(right: 6.w),
              height: 6.h,
              width: _currentSliderIndex == index ? 24.w : 6.w,
              decoration: BoxDecoration(
                color: _currentSliderIndex == index
                    ? AppColor.primaryColor(context)
                    : AppColor.greyColor(context).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
