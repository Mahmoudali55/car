import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, this.user});
final dynamic user;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColor.appBarColor(context),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.r)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackTextColor(context).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primaryColor(context), width: 2),
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColor.greyColor(context).withOpacity(0.1),
                  child: Icon(
                    Icons.person_rounded,
                    size: 60.sp,
                    color: AppColor.primaryColor(context),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.whiteColor(context), width: 2),
                ),
                child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.sp),
              ),
            ],
          ),
          Gap(16.h),
          Text(
            user != null ? '${user.firstName} ${user.lastName}' : '---',
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(4.h),
          Text(
            user?.email ?? '---',
            style: TextStyle(color: AppColor.greyColor(context), fontSize: 14.sp),
          ),
          if (user != null) ...[
            Gap(12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${AppLocaleKey.memberSince.tr()} ${user.createdAt}',
                style: TextStyle(
                  color: AppColor.primaryColor(context),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}