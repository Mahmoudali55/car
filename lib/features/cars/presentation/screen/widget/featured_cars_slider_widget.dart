import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturedCarsSliderWidget extends StatefulWidget {
  final List<Map<String, String>> featuredCars;
  const FeaturedCarsSliderWidget({super.key, required this.featuredCars});

  @override
  State<FeaturedCarsSliderWidget> createState() =>
      _FeaturedCarsSliderWidgetState();
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
          height: 180.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) =>
                setState(() => _currentSliderIndex = index),
            itemCount: widget.featuredCars.length,
            itemBuilder: (context, index) {
              final car = widget.featuredCars[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColor.secondAppColor(context),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.blackTextColor(
                        context,
                      ).withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Container(
                        width: 150.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor(
                            context,
                          ).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor(context),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    AppLocaleKey.specialOffersCars.tr(),
                                    style: AppTextStyle.bodySmall(context)
                                        .copyWith(
                                          color: AppColor.whiteColor(context),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Gap(8.h),
                                Text(
                                  car['name']!,
                                  style: AppTextStyle.titleMedium(context)
                                      .copyWith(
                                        color: AppColor.whiteColor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap(4.h),
                                Text(
                                  car['price']!,
                                  style: AppTextStyle.bodyMedium(context)
                                      .copyWith(
                                        color: AppColor.primaryColor(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Hero(
                              tag: 'featured_car_${car['name']}',
                              child: Image.asset(
                                car['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
