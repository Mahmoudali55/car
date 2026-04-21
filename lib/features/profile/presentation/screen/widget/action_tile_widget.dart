import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ActionTileWidget extends StatelessWidget {
  const ActionTileWidget({super.key, required this.icon, required this.label, required this.onTap});
final IconData icon;final String label;final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(icon, color: AppColor.blackTextColor(context).withOpacity(0.7), size: 22.sp),
            Gap(16.w),
            Text(
              label,
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.greyColor(context).withOpacity(0.5),
              size: 14.sp,
            ),
          ],
        ),
      ),
    ) ;
  }
}