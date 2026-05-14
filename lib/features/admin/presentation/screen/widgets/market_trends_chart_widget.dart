import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/make_group_data_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketTrendsChartWidget extends StatelessWidget {
  const MarketTrendsChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                  if (value.toInt() >= 0 && value.toInt() < months.length) {
                    return Text(
                      months[value.toInt()],
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                        fontSize: 10.sp,
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            makeGroupData(0, 5, 2, context),
            makeGroupData(1, 4, 3, context),
            makeGroupData(2, 6, 1.5, context),
            makeGroupData(3, 8, 4, context),
            makeGroupData(4, 5, 3.5, context),
            makeGroupData(5, 7, 2.5, context),
          ],
        ),
      ),
    );
  }
}
