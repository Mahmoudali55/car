import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CarListCard extends StatelessWidget {
  final AgentCar car;
  final VoidCallback? onTap;
  const CarListCard({super.key, required this.car, this.onTap});

  @override
  Widget build(BuildContext context) {
    final availabilityColor = car.getAvailabilityColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ── Details Area ──
             Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColor.blueColor(context).withOpacity(0.08),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColor.blueColor(context).withOpacity(0.1)),
            ),
            child: Icon(
              Icons.directions_car_filled_rounded,
              size: 38.sp,
              color: AppColor.blueColor(context).withOpacity(0.5),
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Badge & Brand
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text(
                      car.brand,
                      style: TextStyle(
                        color: AppColor.greyColor(context),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: availabilityColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        car.availabilityLabel,
                        style: TextStyle(
                          color: availabilityColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(8.h),

                /// Name
                Text(
                  car.name,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                    letterSpacing: -0.5,
                  ),
                ),
                Gap(4.h),

                /// Price
                Text(
                  '${NumberFormat('#,##0').format(car.price)} ر.س',
                  style: TextStyle(
                    color: AppColor.blueColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                  ),
                ),
                Gap(14.h),

                /// Specs Row
                Row(
                  children: [
                    _SpecItem(icon: Icons.calendar_today_rounded, label: car.year),
                    Gap(12.w),
                    _SpecItem(icon: Icons.speed_rounded, label: '${car.mileage} كم'),
                    Gap(12.w),
                    _ColorIndicator(color: car.color),
                  ],
                ),
              ],
            ),
          ),

          Gap(16.w),

          /// ── Image Area ──
       
        ],
      ),
    ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SpecItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12.sp, color: AppColor.hintColor(context).withOpacity(0.6)),
        Gap(4.w),
        Text(
          label,
          style: TextStyle(
            color: AppColor.hintColor(context),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ColorIndicator extends StatelessWidget {
  final String color;
  const _ColorIndicator({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
            color: Colors.grey, // Ideally map 'color' string to Color
            shape: BoxShape.circle,
          ),
        ),
        Gap(4.w),
        Text(
          color,
          style: TextStyle(
            color: AppColor.hintColor(context),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}