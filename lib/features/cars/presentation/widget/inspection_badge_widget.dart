import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InspectionBadgeWidget extends StatelessWidget {
  const InspectionBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 20),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سيارة موثوقة ومفحوصة',
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'اجتازت هذه السيارة جميع فحوصات الجودة لدينا (200+ نقطة فحص)',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: Colors.white.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
