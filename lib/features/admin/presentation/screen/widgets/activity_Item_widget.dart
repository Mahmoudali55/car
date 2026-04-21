import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ActivityItemWidget extends StatefulWidget {
  const ActivityItemWidget({super.key, required this.index});
  final int index;
  @override
  State<ActivityItemWidget> createState() => _ActivityItemWidgetState();
}

class _ActivityItemWidgetState extends State<ActivityItemWidget> {
  final titles = [
    AppLocaleKey.adminNewCarAddedActivity.tr(),
    AppLocaleKey.adminEditTripPrice.tr(),
    AppLocaleKey.adminNewUserJoinedActivity.tr(),
    AppLocaleKey.adminPaymentFailedBody.tr(),
  ];

  final icons = [
    Icons.add_circle_outline,
    Icons.edit_note_rounded,
    Icons.person_add_alt_1_rounded,
    Icons.error_outline_rounded,
  ];

  final colors = [Colors.blueAccent, Colors.orangeAccent, Colors.greenAccent, Colors.redAccent];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.02),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors[widget.index].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icons[widget.index], color: colors[widget.index], size: 20.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[widget.index],
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocaleKey.adminTwentyFourMinutesAgo.tr(),
                  style: TextStyle(
                    color: AppColor.blackTextColor(context).withOpacity(0.3),
                    fontSize: 10.sp,
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
