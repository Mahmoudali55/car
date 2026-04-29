import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:car/features/cars/presentation/widget/spec_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SpecGridWidget extends StatelessWidget {
  const SpecGridWidget({super.key, required this.car});
  final Map<String, dynamic> car;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet || context.isDesktop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppLocaleKey.basicFeatures.tr()),
        Gap(16.h),
        GridView.count(
          crossAxisCount: isTablet ? 3 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: isTablet ? 2.8 : 2.2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          padding: EdgeInsets.zero,
          children: [
            SpecItemWidget(
              icon: Icons.calendar_today_rounded,
              title: AppLocaleKey.modelYear.tr(),
              value: '${car['year'] ?? car['MAKE_YEAR'] ?? '2024'}',
            ),
            SpecItemWidget(
              icon: Icons.speed_rounded,
              title: AppLocaleKey.mileage.tr(),
              value: '${car['mileage'] ?? car['KILOMETER_READING'] ?? '0'} ${AppLocaleKey.km.tr()}',
            ),
            SpecItemWidget(
              icon: Icons.settings_input_component_rounded,
              title: AppLocaleKey.transmission.tr(),
              value: car['TRANSMISSION'] == 1
                  ? AppLocaleKey.agentAutomatic.tr()
                  : AppLocaleKey.agentManual.tr(),
            ),
            SpecItemWidget(
              icon: Icons.tag_rounded,
              title: AppLocaleKey.agentCarNumber.tr(),
              value: '${car['chassisNo'] ?? car['CHASSIS_NO'] ?? 'N/A'}',
            ),
            SpecItemWidget(
              icon: Icons.color_lens_rounded,
              title: AppLocaleKey.exteriorColor.tr(),
              value: '${car['Color'] ?? car['BODY_COLOR'] ?? "N/A"}',
            ),
            SpecItemWidget(
              icon: Icons.airline_seat_recline_extra_rounded,
              title: AppLocaleKey.capacity.tr(),
              value: '${car['SEAT_NO'] ?? 5} ${AppLocaleKey.agentCars.tr()}',
            ),
            SpecItemWidget(
              icon: Icons.engineering_rounded,
              title: AppLocaleKey.agentSedans.tr(),
              value: '${car['CYLINDER'] ?? "N/A"} ${AppLocaleKey.agentSedan.tr()}',
            ),
            SpecItemWidget(
              icon: Icons.bolt_rounded,
              title: AppLocaleKey.agentHatchbacks.tr(),
              value: '${car['POWER_HOURSE'] ?? "N/A"} ${AppLocaleKey.agentHatchback.tr()}',
            ),
            SpecItemWidget(
              icon: Icons.local_gas_station_rounded,
              title: AppLocaleKey.agentFuelCapacity.tr(),
              value: '${car['FUEL_CAPACITY'] ?? "N/A"} ${AppLocaleKey.agentSuv.tr()}',
            ),
          ],
        ),
      ],
    );
  }
}
