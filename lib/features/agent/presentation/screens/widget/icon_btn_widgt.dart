import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const IconBtn({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: AgentTheme.blue.withOpacity(0.12),
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(color: AgentTheme.blue.withOpacity(0.25)),
        ),
        child: Icon(icon, color: AgentTheme.blue, size: 19.sp),
      ),
    );
  }
}
