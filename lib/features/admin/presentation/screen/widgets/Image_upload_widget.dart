import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.1)),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1583121274602-3e2820c69888?q=80&w=1000',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.6),
                colorBlendMode: BlendMode.darken,
                placeholder: (context, url) =>
                    Container(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
                errorWidget: (context, url, error) => Container(
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
                  child: Icon(
                    Icons.error_outline,
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColor.blackTextColor(context),
                        size: 32.sp,
                      ),
                    ),
                    Gap(12.h),
                    Text(
                      AppLocaleKey.clickToAddCarImages.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocaleKey.transparentBgHint.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
