import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationDepositDisplay extends StatelessWidget {
  final double depositAmount;

  const ReservationDepositDisplay({super.key, required this.depositAmount});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return Center(
      child: Column(
        children: [
          Text(
            AppLocaleKey.depositAmount.tr(),
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          Gap(8.h),
          Text(
            '${formatter.format(depositAmount)} ${AppLocaleKey.sar.tr()}',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w900,
              color: AppColor.blackTextColor(context),
            ),
          ),
        ],
      ),
    );
  }
}
