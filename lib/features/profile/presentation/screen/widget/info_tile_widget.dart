import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InfoTileWidget extends StatelessWidget {
  const InfoTileWidget({super.key, required this.icon, required this.label, required this.value});
 final IconData icon;final String label ; final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryColor(context), size: 22.sp),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: AppColor.greyColor(context), fontSize: 12.sp),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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