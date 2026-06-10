import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RecentlyViewedWidget extends StatelessWidget {
  final List<dynamic> cars;

  const RecentlyViewedWidget({super.key, required this.cars});

  void _navigateToDetails(BuildContext context, Map<String, dynamic> car) {
    NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cars.length,
        separatorBuilder: (context, index) => Gap(12.w),
        itemBuilder: (context, index) {
          final Map<String, dynamic> car = Map<String, dynamic>.from(cars[index]);
          return GestureDetector(
            onTap: () => _navigateToDetails(context, car),
            child: Container(
              width: 200.w,
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor(context).withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: AppColor.dividerColor(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.blackTextColor(context).withValues(alpha: (0.02)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Center(
                        child: car['image'].toString().trim().startsWith('http')
                            ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                                child: CustomNetworkImage(
                                  imageUrl: car['image'],
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                                child: Image.asset(
                                  car['image']!,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                      ),
                    ),
                  ),
                  // Details
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            car['name'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.blackTextColor(context),
                              height: 1.2,
                            ),
                          ),
                          Gap(6.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  '${car['price']}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.titleMedium(context).copyWith(
                                    color: AppColor.primaryColor(context),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 19.sp,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              SvgPicture.asset(
                                AppImages.sar,
                                width: 18.w,
                                height: 18.h,
                                colorFilter: ColorFilter.mode(
                                  AppColor.primaryColor(context),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
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
