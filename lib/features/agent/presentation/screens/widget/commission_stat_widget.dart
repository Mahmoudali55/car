import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommissionStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const CommissionStat({super.key, 
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              height: 1.2,
            ),
          ),
          Gap(4.h),
          Text(
            label,
            style: TextStyle(color: Colors.white38, fontSize: 10.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
