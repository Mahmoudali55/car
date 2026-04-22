import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelBtn extends StatelessWidget {
  final VoidCallback onTap;
  const CancelBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final errorColor = AppColor.redColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: errorColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: errorColor.withOpacity(0.2)),
        ),
        child: Icon(Icons.close_rounded, color: errorColor, size: 20.sp),
      ),
    );
  }
}
