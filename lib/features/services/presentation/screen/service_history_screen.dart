import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> history = [
      {
        'service': AppLocaleKey.periodicMaintenance.tr(),
        'date': '20 March 2024',
        'status': AppLocaleKey.completedStatus.tr(),
        'car': AppLocaleKey.mercedesSClass.tr(),
        'cost': '1,200 ${AppLocaleKey.currencyRiyal.tr()}',
        'icon': Icons.build_rounded,
        'color': Colors.greenAccent,
      },
      {
        'service': AppLocaleKey.oilAndFilterChange.tr(),
        'date': '10 February 2024',
        'status': AppLocaleKey.completedStatus.tr(),
        'car': AppLocaleKey.mercedesSClass.tr(),
        'cost': '450 ${AppLocaleKey.currencyRiyal.tr()}',
        'icon': Icons.oil_barrel_rounded,
        'color': Colors.blueAccent,
      },
      {
        'service': AppLocaleKey.nanoCeramicPolishing.tr(),
        'date': '05 January 2024',
        'status': AppLocaleKey.completedStatus.tr(),
        'car': AppLocaleKey.mercedesSClass.tr(),
        'cost': '2,500 ${AppLocaleKey.currencyRiyal.tr()}',
        'icon': Icons.auto_awesome_rounded,
        'color': Colors.purpleAccent,
      },
      {
        'service': AppLocaleKey.comprehensiveInspection.tr(),
        'date': '15 December 2023',
        'status': AppLocaleKey.cancelledStatus.tr(),
        'car': AppLocaleKey.bmwX5.tr(),
        'cost': '0 ${AppLocaleKey.currencyRiyal.tr()}',
        'icon': Icons.fact_check_rounded,
        'color': Colors.redAccent,
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.myServiceHistory.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return FadeInUp(
            delay: Duration(milliseconds: 100 * index),
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: item['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(item['icon'], color: item['color'], size: 24.sp),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['service'],
                              style: TextStyle(
                                color: AppColor.blackTextColor(context),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['cost'],
                              style: TextStyle(
                                color: item['color'],
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Gap(4.h),
                        Text(
                          "${item['car']} • ${item['date']}",
                          style: TextStyle(
                            color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
                            fontSize: 11.sp,
                          ),
                        ),
                        Gap(8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: item['status'] == AppLocaleKey.cancelledStatus.tr()
                                ? Colors.red.withValues(alpha: (0.1))
                                : Colors.green.withValues(alpha: (0.1)),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            item['status'],
                            style: TextStyle(
                              color: item['status'] == AppLocaleKey.cancelledStatus.tr()
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
