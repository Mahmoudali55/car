import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/quick_info_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/spec_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomAgentCarDetailsInfoWidget extends StatelessWidget {
  const CustomAgentCarDetailsInfoWidget({super.key, required this.car});

  final AgentCar car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// QUICK INFO
        Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: AppColor.cardColor(context),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.blackColor(context).withValues(alpha: .04),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QuickInfo(
                icon: Icons.calendar_today_rounded,
                title: AppLocaleKey.agentYearMade.tr(),
                value: car.year,
              ),
              QuickInfo(
                icon: Icons.numbers,
                title: AppLocaleKey.agentSimNumber.tr(),
                value: car.mileage,
              ),
              QuickInfo(
                icon: Icons.palette_rounded,
                title: AppLocaleKey.agentColor.tr(),
                value: car.color,
              ),
            ],
          ),
        ),
        Gap(30.h),
        Text(
          AppLocaleKey.agentMainSpecs.tr(),
          style: AppTextStyle.bodyLarge(context).copyWith(fontWeight: FontWeight.w900),
        ),
        Gap(16.h),
        SpecTile(
          icon: Icons.calendar_today_rounded,
          title: AppLocaleKey.agentYearMade.tr(),
          value: car.year,
        ),
        SpecTile(
          icon: Icons.numbers,
          title: AppLocaleKey.agentSimNumber.tr(),
          value: '${car.mileage} ',
        ),
        SpecTile(
          icon: Icons.palette_rounded,
          title: AppLocaleKey.agentColor.tr(),
          value: car.color,
        ),
        SpecTile(
          icon: Icons.settings_rounded,
          title: AppLocaleKey.agentTransmission.tr(),
          value: AppLocaleKey.agentAutomatic.tr(),
        ),
        Gap(120.h),
      ],
    );
  }
}
