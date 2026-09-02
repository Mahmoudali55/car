import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, 
    required this.label,
    required this.value,
    required this.icon,
    required this.context,
    this.highlight = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final BuildContext context;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: highlight
            ? AppColor.primaryColor(context).withValues(alpha: 0.08)
            : AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: highlight
            ? Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.25))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: highlight ? AppColor.primaryColor(context) : AppColor.greyColor(context),
          ),
          Gap(8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context), fontSize: 10.sp),
                ),
                Gap(2.h),
                ValueWithCurrencyIcon(
                  text: value,
                  textStyle: AppTextStyle.bodySmall(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: highlight
                        ? AppColor.primaryColor(context)
                        : AppColor.blackTextColor(context),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
