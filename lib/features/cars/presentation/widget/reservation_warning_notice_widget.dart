import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationWarningNotice extends StatelessWidget {
  const ReservationWarningNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20.sp),
          Gap(8.w),
          Expanded(
            child: Text(
              AppLocaleKey.nameMustMatch.tr(),
              style: TextStyle(color: Colors.amber[800], fontSize: 12.sp, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}