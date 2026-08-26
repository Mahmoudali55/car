import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PasswordHintChip extends StatelessWidget {
  const PasswordHintChip({super.key, required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final color = met ? Colors.green : Colors.redAccent;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              met ? Icons.check_circle_rounded : Icons.cancel_rounded,
              key: ValueKey(met),
              color: color,
              size: 14.sp,
            ),
          ),
          Gap(5.w),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 11.5.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
