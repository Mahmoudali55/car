import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const FeatureCard({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: (0.08))),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: (0.04)),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context).withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 22.sp, color: AppColor.primaryColor(context)),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bodyLarge(
              context,
            ).copyWith(fontWeight: FontWeight.w800, color: AppColor.blackColor(context)),
          ),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
