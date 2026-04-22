import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumQuickAction extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  const PremiumQuickAction({required this.icon, required this.label, required this.color});

  @override
  State<PremiumQuickAction> createState() => PremiumQuickActionState();
}

class PremiumQuickActionState extends State<PremiumQuickAction> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(_isHovered ? 0.12 : 0.08),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: widget.color.withOpacity(0.25)),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 12.r,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.color, size: 24.sp),
              Gap(8.h),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.color,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}