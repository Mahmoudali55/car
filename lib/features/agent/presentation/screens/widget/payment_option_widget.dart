import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final String code;
  final bool selected;
  final VoidCallback onTap;
  final BuildContext context;
  const PaymentOption({
    super.key,
    required this.label,
    required this.icon,
    required this.code,
    required this.selected,
    required this.onTap,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final primary = AppColor.primaryColor(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: selected ? primary : primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected ? primary : primary.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: selected ? AppColor.whiteColor(context) : primary),
              Gap(8.w),
              Text(
                label,
                style: AppTextStyle.bodyMedium(context).copyWith(
                  color: selected ? AppColor.whiteColor(context) : primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
