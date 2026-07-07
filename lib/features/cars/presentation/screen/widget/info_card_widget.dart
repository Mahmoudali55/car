import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({super.key, required this.rows});
  final List<InfoRow> rows;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final row = rows[i];
          final bool isLast = i == rows.length - 1;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: row.iconColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(row.icon, color: row.iconColor, size: 18.sp),
                    ),
                    Gap(14.w),
                    Text(
                      row.label,
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(14.w),
                    Expanded(
                      child: Text(
                        row.value,
                        style: AppTextStyle.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.w900, fontSize: 14.sp),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  color: AppColor.borderColor(context).withValues(alpha: 0.5),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class InfoRow {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });
}
