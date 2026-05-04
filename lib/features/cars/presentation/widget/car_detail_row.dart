import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? colorBox;
  final bool isLast;

  const CarDetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.colorBox,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Right side in RTL (Label + Icon)
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: AppColor.greyColor(context), size: 20.sp),
                Gap(8.w),
                Flexible(
                  child: Text(
                    label,
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(12.w),
          // Left side in RTL (Value + Optional ColorBox)
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.blackTextColor(context),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                if (colorBox != null) ...[
                  Gap(8.w),
                  Container(
                    width: 20.w,
                    height: 20.w,
                    margin: EdgeInsets.only(top: 2.h), // slight alignment tweak
                    decoration: BoxDecoration(
                      color: colorBox,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
