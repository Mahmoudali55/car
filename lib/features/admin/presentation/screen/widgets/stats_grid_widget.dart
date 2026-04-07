import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/widget/admin_stats_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StatsGridWidget extends StatelessWidget {
  const StatsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminTotalCars.tr(),
                value: '124',
                icon: Icons.directions_car_filled_rounded,
                color: AppColor.primaryColor(context),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminSoldCars.tr(),
                value: '86',
                icon: Icons.shopping_bag_rounded,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
        Gap(16.h),
        AdminStatsCard(
          title: AppLocaleKey.adminPendingApprovals.tr(),
          value: '12',
          icon: Icons.pending_actions_rounded,
          color: Colors.orangeAccent,
        ),
      ],
    );
  }
}
