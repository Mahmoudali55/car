import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CarGridCard extends StatelessWidget {
  final AgentCar car;
  const CarGridCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final availabilityColor = car.getAvailabilityColor(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image area ──────────────────────────────────────────────────
          Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.blueColor(context).withOpacity(0.08),
                  AppColor.blueColor(context).withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.directions_car_filled_rounded,
                    size: 56.sp,
                    color: AppColor.blueColor(context).withOpacity(0.15),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: availabilityColor,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: availabilityColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      car.availabilityLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Info ────────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.brand.toUpperCase(),
                  style: TextStyle(
                    color: AppColor.greyColor(context),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                Gap(2.h),
                Text(
                  car.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 15.sp,
                  ),
                ),
                Gap(4.h),
                Text(
                  '${NumberFormat('#,##0').format(car.price)} ر.س',
                  style: TextStyle(
                    color: AppColor.blueColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(8.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 11.sp, color: AppColor.hintColor(context).withOpacity(0.7)),
                    Gap(4.w),
                    Text(
                      car.year,
                      style: TextStyle(color: AppColor.hintColor(context), fontSize: 10.sp, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Icon(Icons.speed_rounded, size: 11.sp, color: AppColor.hintColor(context).withOpacity(0.7)),
                    Gap(4.w),
                    Text(
                      '${car.mileage} كم',
                      style: TextStyle(color: AppColor.hintColor(context), fontSize: 10.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (car.availability == CarAvailability.available) ...[
                  Gap(12.h),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColor.blueColor(context), AppColor.blueColor(context).withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.blueColor(context).withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'احجز للعميل',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
