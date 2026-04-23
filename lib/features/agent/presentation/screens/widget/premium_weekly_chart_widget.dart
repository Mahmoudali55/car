import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumWeeklyChart extends StatelessWidget {
  final List<int> data;
  final List<String> days;
  const PremiumWeeklyChart({super.key, required this.data, required this.days});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final blueColor = AppColor.blueColor(context);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'النشاط الأسبوعي',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                  letterSpacing: -0.2,
                ),
              ),
              Text(
                'آخر 7 أيام',
                style: TextStyle(
                  color: AppColor.hintColor(context),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Gap(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(data.length, (i) {
              final isPeak = data[i] == maxVal;
              final barH = (data[i] / maxVal * 100.h).clamp(15.0, 100.0);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isPeak)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color: AppColor.goldColor(context),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.goldColor(context).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${data[i]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10.sp,
                        ),
                      ),
                    )
                  else
                    Gap(28.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                    width: 32.w,
                    height: barH,
                    decoration: BoxDecoration(
                      gradient: isPeak
                          ? LinearGradient(
                              colors: [blueColor, blueColor.withOpacity(0.7)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                      color: isPeak ? null : blueColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: isPeak
                          ? [
                              BoxShadow(
                                color: blueColor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    days[i],
                    style: TextStyle(
                      color: AppColor.hintColor(context),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
