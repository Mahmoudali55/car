import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomCustomerItemDataWidget extends StatelessWidget {
  const CustomCustomerItemDataWidget({super.key, required this.customerName, required this.phone});

  final String customerName;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Avatar
        Container(
          width: 58.w,
          height: 58.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.blueColor(context),
                AppColor.blueColor(context).withValues(alpha: .7),
              ],
            ),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Center(
            child: Text(
              customerName.isNotEmpty ? customerName[0].toUpperCase() : '?',
              style: AppTextStyle.bodyLarge(context).copyWith(
                color: AppColor.whiteColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 22.sp,
              ),
            ),
          ),
        ),

        Gap(14.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w800),
              ),

              Gap(6.h),

              Row(
                children: [
                  Icon(Icons.phone_rounded, size: 15.sp, color: AppColor.greyColor(context)),
                  Gap(5.w),
                  Text(
                    phone,
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColor.blueColor(context).withValues(alpha: .08),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            AppLocaleKey.agentCustomer.tr(),
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.blueColor(context),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
