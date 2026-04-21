import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ContactHeaderWidget extends StatelessWidget {
  const ContactHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.technicalSupportTicket.tr(),
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(8.h),
          Text(
            "Report bugs, request features, or ask technical questions directly to the development team.",
            style: TextStyle(
              color: AppColor.blackTextColor(context).withOpacity(0.5),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
