import 'package:car/core/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BarChartGroupData makeGroupData(int x, double y1, double y2, BuildContext context) {
  return BarChartGroupData(
    barsSpace: 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: AppColor.primaryColor(context),
        width: 8.w,
        borderRadius: BorderRadius.circular(4.r),
      ),
      BarChartRodData(
        toY: y2,
        color: AppColor.blueColor(context).withValues(alpha: (0.3)),
        width: 8.w,
        borderRadius: BorderRadius.circular(4.r),
      ),
    ],
  );
}
