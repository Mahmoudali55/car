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
    return Container(
      decoration: BoxDecoration(
        color: AgentTheme.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: car.availabilityColor.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Container(
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.directions_car_filled_rounded,
                      size: 52.sp, color: Colors.white.withOpacity(0.07)),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: car.availabilityColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(car.availabilityLabel,
                        style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          // Info
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(car.brand, style: TextStyle(color: AgentTheme.text3, fontSize: 10.sp)),
                Text(car.name,
                    style: TextStyle(color: AgentTheme.text1, fontWeight: FontWeight.w900, fontSize: 14.sp)),
                Gap(6.h),
                Text(
                  '${NumberFormat('#,##0').format(car.price)} ر.س',
                  style: TextStyle(color: AgentTheme.blue, fontWeight: FontWeight.w900, fontSize: 13.sp),
                ),
                Gap(8.h),
                Row(children: [
                  Icon(Icons.calendar_today_rounded, size: 10.sp, color: AgentTheme.text3),
                  Gap(3.w),
                  Text(car.year, style: TextStyle(color: AgentTheme.text3, fontSize: 9.sp)),
                  Gap(10.w),
                  Icon(Icons.speed_rounded, size: 10.sp, color: AgentTheme.text3),
                  Gap(3.w),
                  Text('${car.mileage} كم', style: TextStyle(color: AgentTheme.text3, fontSize: 9.sp)),
                ]),
                if (car.availability == CarAvailability.available) ...[
                  Gap(10.h),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AgentTheme.blue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text('احجز للعميل',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold)),
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
