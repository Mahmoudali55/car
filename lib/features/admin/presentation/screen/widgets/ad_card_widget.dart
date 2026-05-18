import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdCardWidget extends StatefulWidget {
  const AdCardWidget({super.key, required this.index});
  final int index;

  @override
  State<AdCardWidget> createState() => _AdCardWidgetState();
}

class _AdCardWidgetState extends State<AdCardWidget> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: (0.02)),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.05))),
      ),
      child: Row(
        children: [
          Container(
            width: 120.w,
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: (0.1)),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(24.r)),
              image: const DecorationImage(
                image: AssetImage(AppImages.assetsImagesGclass),
                fit: BoxFit.cover,
              ),
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
                      color: AppColor.blackTextColor(context).withValues(alpha: (0.4)),
                      fontSize: 10.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Switch.adaptive(
                        value: _isActive,
                        inactiveTrackColor: AppColor.blackTextColor(
                          context,
                        ).withValues(alpha: (0.1)),
                        splashRadius: 20.r,
                        activeTrackColor: AppColor.primaryColor(context).withValues(alpha: (0.3)),
                        onChanged: (v) {
                          setState(() {
                            _isActive = v;
                          });
                        },
                        activeThumbColor: AppColor.primaryColor(context),
                      ),
                      Gap(8.w),
                      Text(
                        _isActive ? AppLocaleKey.activeLabel.tr() : AppLocaleKey.inactiveLabel.tr(),
                        style: TextStyle(
                          color: _isActive
                              ? AppColor.primaryColor(context)
                              : AppColor.blackTextColor(context).withValues(alpha: 0.4),
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
