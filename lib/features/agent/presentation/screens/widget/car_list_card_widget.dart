import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CarListCard extends StatelessWidget {
  final AgentCar car;
  const CarListCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AgentTheme.card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: car.availabilityColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AgentTheme.border),
            ),
            child: Icon(Icons.directions_car_filled_rounded,
                size: 32.sp, color: Colors.white.withOpacity(0.12)),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(car.brand, style: TextStyle(color: AgentTheme.text3, fontSize: 11.sp)),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: car.availabilityColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(7.r),
                      border: Border.all(color: car.availabilityColor.withOpacity(0.3)),
                    ),
                    child: Text(car.availabilityLabel,
                        style: TextStyle(color: car.availabilityColor, fontSize: 10.sp, fontWeight: FontWeight.bold)),
                  ),
                ]),
                Text(car.name,
                    style: TextStyle(color: AgentTheme.text1, fontWeight: FontWeight.w900, fontSize: 15.sp)),
                Gap(4.h),
                Text('${NumberFormat('#,##0').format(car.price)} ر.س',
                    style: TextStyle(color: AgentTheme.blue, fontWeight: FontWeight.w900, fontSize: 14.sp)),
                Gap(4.h),
                Row(children: [
                  Icon(Icons.calendar_today_rounded, size: 11.sp, color: AgentTheme.text3),
                  Gap(4.w),
                  Text(car.year, style: TextStyle(color: AgentTheme.text3, fontSize: 10.sp)),
                  Gap(12.w),
                  Icon(Icons.speed_rounded, size: 11.sp, color: AgentTheme.text3),
                  Gap(4.w),
                  Text('${car.mileage} كم', style: TextStyle(color: AgentTheme.text3, fontSize: 10.sp)),
                  Gap(12.w),
                  Icon(Icons.circle, size: 8.sp, color: AgentTheme.text3),
                  Gap(4.w),
                  Text(car.color, style: TextStyle(color: AgentTheme.text3, fontSize: 10.sp)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}