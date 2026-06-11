import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:car/features/admin/presentation/cubit/admin_state.dart';
import 'package:car/features/admin/presentation/widget/admin_stats_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StatsGridWidget extends StatefulWidget {
  const StatsGridWidget({super.key});

  @override
  State<StatsGridWidget> createState() => _StatsGridWidgetState();
}

class _StatsGridWidgetState extends State<StatsGridWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getCarsCountStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        final status = state.getCarsCountStatus;

        int totalCars = 0;
        int soldCars = 0;
        int pendingApprovals = 0;
        int availableCars = 0;

        String? soldPerc;
        String? pendingPerc;
        String? availablePerc;

        String? totalCarss;

        if (status.isSuccess && status.data != null) {
          final dataList = status.data!;
          final stats = dataList.isNotEmpty ? dataList.first : null;

          if (stats != null) {
            totalCars = stats.avaliable + stats.reserved + stats.sold + stats.returnSupplier;
            soldCars = stats.sold;
            pendingApprovals = stats.reserved;
            availableCars = stats.avaliable;

            if (totalCars > 0) {
              soldPerc = '+${((soldCars / totalCars) * 100).toStringAsFixed(0)}%';
              pendingPerc = '+${((pendingApprovals / totalCars) * 100).toStringAsFixed(0)}%';
              availablePerc = '+${((availableCars / totalCars) * 100).toStringAsFixed(0)}%';
              totalCarss = '+${((totalCars / totalCars) * 100).toStringAsFixed(0)} %';
              ;
            }
          }
        }

        return _buildGrid(
          context: context,
          totalCars: totalCars.toString(),
          soldCars: soldCars.toString(),
          pendingApprovals: pendingApprovals.toString(),
          availableCars: availableCars.toString(),
          soldPerc: soldPerc,
          pendingPerc: pendingPerc,
          availablePerc: availablePerc,
          totalCarsss: totalCarss,
        );
      },
    );
  }

  Widget _buildGrid({
    required BuildContext context,
    required String totalCars,
    required String soldCars,
    required String pendingApprovals,
    required String availableCars,
    String? soldPerc,
    String? pendingPerc,
    String? availablePerc,
    String? totalCarsss,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminTotalCars.tr(),
                value: totalCars,
                icon: Icons.directions_car_filled_rounded,
                color: AppColor.primaryColor(context),
                percentage: totalCarsss,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminSoldCars.tr(),
                value: soldCars,
                icon: Icons.shopping_bag_rounded,
                color: AppColor.greenColor(context),
                percentage: soldPerc,
              ),
            ),
          ],
        ),
        Gap(16.h),
        Row(
          children: [
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminPendingApprovals.tr(),
                value: pendingApprovals,
                icon: Icons.pending_actions_rounded,
                color: AppColor.orangeColor(context),
                percentage: pendingPerc,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.admin_available_cars.tr(),
                value: availableCars,
                icon: Icons.directions_car_filled_rounded,
                color: AppColor.redColor(context),
                percentage: availablePerc,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
