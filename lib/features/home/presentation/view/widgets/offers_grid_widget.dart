import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersGridWidget extends StatelessWidget {
  const OffersGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor(context).withOpacity(0.04),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.directions_car_rounded,
                          color: AppColor.primaryColor(context),
                          size: 55.w,
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffFF3B30),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            "-15%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.grey,
                            size: 16.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mercedes G63 AMG",
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        _buildCarDetail(context, Icons.calendar_today_outlined, "2024"),
                        SizedBox(width: 8.w),
                        _buildCarDetail(context, Icons.speed_outlined, "0 km"),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AED 850k",
                              style: AppTextStyle.titleSmall(
                                context,
                                color: AppColor.primaryColor(context),
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primaryColor(context).withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(Icons.add_rounded, color: Colors.white, size: 20.w),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarDetail(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 12.w),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
        ),
      ],
    );
  }
}
