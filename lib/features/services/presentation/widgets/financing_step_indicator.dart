import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingStepIndicator extends StatelessWidget {
  final int currentStep;
  const FinancingStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final primary = AppColor.primaryColor(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final isActive = currentStep >= index;
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}'.padLeft(2, '0'),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: isActive
                        ? AppColor.blackTextColor(context)
                        : AppColor.blackTextColor(context).withValues(alpha: 0.3),
                    fontWeight: FontWeight.w900,
                    fontSize: 10.sp,
                    letterSpacing: 1.5,
                  ),
                ),
                Gap(8.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: 2.h,
                  margin: EdgeInsets.only(right: index < 4 ? 8.w : 0),
                  decoration: BoxDecoration(
                    color: isActive
                        ? primary
                        : AppColor.blackTextColor(context).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: isActive
                        ? [BoxShadow(color: primary.withValues(alpha: 0.3), blurRadius: 4)]
                        : [],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
