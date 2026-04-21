import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationTrustBadge extends StatelessWidget {
  const ReservationTrustBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffc8e6c9).withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: Colors.grey, size: 20.sp),
          Gap(12.w),
          Expanded(
            child: Text(
              "شركة موقع سيارة للتجارة شركة موثقة لدى وزارة التجارة والاستثمار وبدعم من شركة علم.",
              style: AppTextStyle.bodySmall(context).copyWith(
                fontSize: 11.sp,
                color: AppColor.blackTextColor(context).withOpacity(0.6),
                height: 1.5,
              ),
            ),
          ),
          Gap(12.w),
          Icon(Icons.verified_user_rounded, color: const Color(0xFF2E7D32), size: 24.sp),
        ],
      ),
    );
  }
}
