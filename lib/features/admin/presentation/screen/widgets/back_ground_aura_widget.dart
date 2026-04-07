import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGroundAuraWidget extends StatelessWidget {
  const BackGroundAuraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -150.h,
      right: -150.w,
      child: Container(
        width: 400.w,
        height: 400.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF3B82F6).withValues(alpha: 0.05),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.05),
              blurRadius: 100,
              spreadRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}
