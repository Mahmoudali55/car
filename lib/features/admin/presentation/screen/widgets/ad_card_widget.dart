import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdCardWidget extends StatelessWidget {
  const AdCardWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 120.w,
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(24.r)),
            ),
            child: Icon(
              Icons.image_outlined,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
              size: 30.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocaleKey.mercedesAdTitle.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocaleKey.expiryDateLabel.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                      fontSize: 10.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Switch.adaptive(
                        value: true,
                        onChanged: (v) {},
                        activeColor: AppColor.primaryColor(context),
                      ),
                      Text(
                        AppLocaleKey.activeLabel.tr(),
                        style: TextStyle(
                          color: AppColor.primaryColor(context),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
