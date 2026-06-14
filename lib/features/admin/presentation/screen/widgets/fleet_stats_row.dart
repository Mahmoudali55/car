import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/admin/data/model/stock_statistics_model.dart';
import 'package:car/features/admin/presentation/screen/widgets/stat_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FleetStatsRow extends StatelessWidget {
  final StockStatisticsModel? stats;

  const FleetStatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final s = stats;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Row(
        children: [
          StatCard(
            count: s?.avaliable ?? 0,
            label: AppLocaleKey.agentCarAvailable.tr(),
            dotColor: const Color(0xFF639922),
            context: context,
          ),
          Gap(8.w),
          StatCard(
            count: s?.reserved ?? 0,
            label: AppLocaleKey.adminPendingApprovals.tr(),
            dotColor: const Color(0xFFEF9F27),
            context: context,
          ),
          Gap(8.w),
          StatCard(
            count: s?.sold ?? 0,
            label: AppLocaleKey.agentCarSold.tr(),
            dotColor: const Color(0xFFE24B4A),
            context: context,
          ),
          Gap(8.w),
          StatCard(
            count: s?.returnSupplier ?? 0,
            label: AppLocaleKey.horizontal.tr(),
            dotColor: const Color(0xFF7C5CBF),
            context: context,
          ),
        ],
      ),
    );
  }
}
