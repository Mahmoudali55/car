import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_profile_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileHeaderBannerWidget extends StatelessWidget {
  const ProfileHeaderBannerWidget({
    super.key,
    required this.profile,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final CustomerProfileModel? profile;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor(context),
              AppColor.primaryColor(context).withValues(alpha: 0.8),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor(context).withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54.w,
              height: 54.w,
              decoration: BoxDecoration(
                color: AppColor.whiteColor(context).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_rounded,
                color: AppColor.whiteColor(context).withValues(alpha: 0.9),
                size: 30.sp,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile!.displayName.isNotEmpty
                        ? profile!.displayName
                        : (_nameController.text.isNotEmpty
                              ? _nameController.text
                              : (AppLocaleKey.customer.tr())),
                    style: AppTextStyle.titleMedium(
                      context,
                    ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
                  ),
                  if (profile!.customerTypeName != null &&
                      profile!.customerTypeName!.isNotEmpty) ...[
                    Gap(4.h),
                    Text(
                      profile!.customerTypeName!,
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.whiteColor(context).withValues(alpha: 0.85)),
                    ),
                  ],
                  if (profile!.customerNo != null) ...[
                    Gap(2.h),
                    Text(
                      '${AppLocaleKey.customerId.tr()} #${profile!.customerNo}',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.whiteColor(context).withValues(alpha: 0.7),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
