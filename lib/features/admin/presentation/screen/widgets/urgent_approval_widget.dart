import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UrgentApprovalWidget extends StatelessWidget {
  const UrgentApprovalWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocaleKey.urgentApprovalRequests.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              AppLocaleKey.adminThreeRequests.tr(),
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Gap(16.h),
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => Gap(16.w),
            itemBuilder: (context, index) => Container(
              width: 250.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.orangeAccent.withValues(alpha: (0.3))),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor(context).withValues(alpha: (0.05)),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor: Colors.orangeAccent.withValues(alpha: (0.2)),
                        child: Icon(Icons.warning_rounded, color: Colors.orangeAccent, size: 14.sp),
                      ),
                      Gap(8.w),
                      Text(
                        AppLocaleKey.approvalRequest.tr(),
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    AppLocaleKey.agentRequested.tr(),
                    style: TextStyle(color: AppColor.greyColor(context), fontSize: 12.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          radius: 12.r,
                          color: AppColor.greenColor(context),
                          onPressed: () {},
                          child: Text(
                            AppLocaleKey.approve.tr(),
                            style: TextStyle(color: AppColor.whiteColor(context), fontSize: 12.sp),
                          ),
                        ),
                      ),
                      Gap(8.w),
                      Expanded(
                        child: CustomButton(
                          radius: 12.r,
                          onPressed: () {},
                          color: AppColor.redColor(context),
                          child: Text(
                            AppLocaleKey.reject.tr(),
                            style: TextStyle(color: AppColor.whiteColor(context), fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
