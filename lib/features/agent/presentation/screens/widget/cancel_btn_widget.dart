import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelBtn extends StatelessWidget {
  final VoidCallback onTap;
  const CancelBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AgentTheme.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AgentTheme.red.withOpacity(0.3)),
        ),
        child: Icon(Icons.close_rounded, color: AgentTheme.red, size: 18.sp),
      ),
    );
  }
}
