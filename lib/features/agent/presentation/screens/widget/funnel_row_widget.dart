import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FunnelRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;
  const FunnelRow({super.key, required this.label, required this.count, required this.total, required this.color});

  @override
  Widget build(BuildContext context) {
    final pct = count / total;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: const Color(0xFF0A1628))),
              Text('$count / $total', style: TextStyle(fontWeight: FontWeight.w900, color: color, fontSize: 14.sp)),
            ],
          ),
          Gap(10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}
