import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MiniSpecWidget extends StatelessWidget {
  const MiniSpecWidget({super.key, required this.icon, required this.value});
  final IconData icon;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.blackTextColor(context).withValues(alpha: 0.24), size: 13.sp),
        Gap(4.w),
        Text(
          value,
          style: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
    ;
  }
}
