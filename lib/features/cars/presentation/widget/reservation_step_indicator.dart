import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationStepIndicator extends StatelessWidget {
  final int currentStep;
  final bool isFinancingFlow;

  const ReservationStepIndicator({
    super.key,
    required this.currentStep,
    this.isFinancingFlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final steps = isFinancingFlow
        ? [
            {'label': 'المعلومات الشخصية', 'index': 0},
          ]
        : [
            {'label': 'أضف معلوماتك', 'index': 0},
            {'label': 'التحقق من الرمز', 'index': 1},
            {'label': 'الدفع', 'index': 2},
          ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          Row(
            children: List.generate(steps.length, (index) {
              final isActive = index <= currentStep;
              final isLast = index == steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2.h,
                        color: isActive ? AppColor.primaryColor(context) : AppColor.borderColor(context),
                      ),
                    ),
                    if (isLast) ...[
                      // Small spacer instead of a line for the last one
                      const Spacer(),
                    ],
                  ],
                ),
              );
            }),
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.map((step) {
              final index = step['index'] as int;
              final isActive = index == currentStep;
              final isCompleted = index < currentStep;

              return Text(
                step['label'] as String,
                style: AppTextStyle.bodySmall(context).copyWith(
                  fontWeight: isActive || isCompleted ? FontWeight.w900 : FontWeight.bold,
                  color: isActive || isCompleted
                      ? AppColor.primaryColor(context)
                      : AppColor.blackTextColor(context).withOpacity(0.3),
                  fontSize: 12.sp,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
