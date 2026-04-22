import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  final AgentLead lead;
  const StatusBadge({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: lead.statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: lead.statusColor.withOpacity(0.3)),
      ),
      child: Text(lead.statusLabel,
          style: TextStyle(
              color: lead.statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp)),
    );
  }
}