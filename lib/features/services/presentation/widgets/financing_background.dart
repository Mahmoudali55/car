import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancingBackground extends StatelessWidget {
  const FinancingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.8),
                radius: 1.2,
                colors: [
                  AppColor.gradientSecondaryColor(context),
                  AppColor.scaffoldColor(context),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -50.h,
          left: 0,
          right: 0,
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.whiteColor(context).withValues(alpha: 0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
