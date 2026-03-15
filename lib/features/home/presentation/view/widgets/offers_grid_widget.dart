import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OffersGridWidget extends StatelessWidget {
  const OffersGridWidget({super.key});

  final List<Map<String, dynamic>> _offers = const [
    {
      'name': 'G63 AMG 2024',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': '850,000 د.إ',
      'oldPrice': '1,000,000 د.إ',
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
      'price': '440,000 د.إ',
      'oldPrice': '520,000 د.إ',
      'discount': '10%',
      'year': '2023',
      'mileage': '5,000 كم',
      'engine': '4.4L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
    },
    {
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'image': 'assets/images/cars/toyota.png',
      'price': '330,000 د.إ',
      'oldPrice': '350,000 د.إ',
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
      'price': '450,000 د.إ',
      'oldPrice': '480,000 د.إ',
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
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _offers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62, // Slightly taller for more elegance
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
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Image Area
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: Colors.white.withOpacity(0.02),
                        padding: EdgeInsets.all(16.w),
                        child: Hero(
                          tag: 'car_image_${car['name']}',
                          child: Image.asset(car['image'], fit: BoxFit.contain),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 40.h,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColor.secondAppColor(context),
                                AppColor.secondAppColor(context).withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF3B30), Color(0xFFFF5050)],
                            ),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.r)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF3B30).withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            "خصم ${car['discount']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: CircleAvatar(
                          radius: 14.r,
                          backgroundColor: AppColor.scaffoldColor(context).withOpacity(0.6),
                          child: Icon(
                            car['isFavorite'] ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: car['isFavorite'] ? Colors.redAccent : Colors.white,
                            size: 16.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Details Area
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['brand'],
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColor.primaryColor(context),
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                            Gap(2.h),
                            Text(
                              car['name'],
                              style: AppTextStyle.titleSmall(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildCarDetail(context, Icons.speed_outlined, car['mileage']),
                            Gap(8.w),
                            _buildCarDetail(context, Icons.local_gas_station_outlined, "بنزين"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car['oldPrice'],
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColor.greyColor(context),
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  car['price'],
                                  style: AppTextStyle.titleSmall(
                                    context,
                                    color: AppColor.primaryColor(context),
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primaryColor(context).withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 14.w,
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
    );
  }

  Widget _buildCarDetail(BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.greyColor(context), size: 12.w),
          Gap(4.w),
          Text(
            label,
            style: TextStyle(color: AppColor.greyColor(context), fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}
