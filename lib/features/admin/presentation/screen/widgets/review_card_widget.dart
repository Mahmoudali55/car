import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/action_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReviewCardWidget extends StatelessWidget {
  const ReviewCardWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: (0.02)),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.05))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColor.blackTextColor(context).withValues(alpha: (0.05)),
                    child: Icon(
                      Icons.person,
                      size: 18.sp,
                      color: AppColor.blackTextColor(context).withValues(alpha: (0.5)),
                    ),
                  ),
                  Gap(12.w),
                  Text(
                    AppLocaleKey.mohamedAlshammari.tr(),
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.blackTextColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(Icons.star_rounded, color: Colors.orangeAccent, size: 14.sp),
                ),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            AppLocaleKey.dummyReviewText.tr(),
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: (0.7))),
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: ActionBtnWidget(
                  label: AppLocaleKey.adminHide.tr(),
                  color: AppColor.redColor(context),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: ActionBtnWidget(
                  label: AppLocaleKey.adminApprove.tr(),
                  color: AppColor.greenColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
