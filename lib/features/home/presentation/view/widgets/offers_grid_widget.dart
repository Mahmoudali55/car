import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OffersGridWidget extends StatelessWidget {
  const OffersGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62, // Slightly taller for more elegance
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) {
        return Container(
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
            // A subtle stroke around the card for a premium look in dark mode
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
                    // Background placeholder for image
                    Container(
                      color: Colors.white.withOpacity(0.02),
                      padding: EdgeInsets.all(16.w),
                      child: Image.asset(
                        'assets/images/cars/mercedes-benz.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Gradient overlay to blend image into the dark card
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

                    // Discount Badge
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
                          "خصم 15%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Favorite Icon
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: CircleAvatar(
                        radius: 14.r,
                        backgroundColor: AppColor.scaffoldColor(context).withOpacity(0.6),
                        child: Icon(Icons.favorite_border_rounded, color: Colors.white, size: 16.w),
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
                            "Mercedes-Benz",
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                          Gap(2.h),
                          Text(
                            "G63 AMG 2024",
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

                      // Specs Row
                      Row(
                        children: [
                          _buildCarDetail(context, Icons.speed_outlined, "0 كم"),
                          Gap(8.w),
                          _buildCarDetail(context, Icons.local_gas_station_outlined, "بنزين"),
                        ],
                      ),

                      // Price & Add Button Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1,000,000 د.إ",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColor.greyColor(context),
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                "850,000 د.إ",
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
