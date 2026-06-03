import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  final AgentLead lead;
  const StatusBadge({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    final statusColor = lead.getStatusColor(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: statusColor.withValues(alpha: 0.15)),
      ),
      child: Text(
        lead.statusLabel,
        style: AppTextStyle.bodySmall(context).copyWith(
          color: statusColor,
          fontWeight: FontWeight.w800,
          fontSize: 11.sp,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
