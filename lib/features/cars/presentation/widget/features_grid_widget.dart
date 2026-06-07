import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturesGridWidget extends StatelessWidget {
  final GetBrandCarsDataModel car;

  const FeaturesGridWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [];

    final mileage = car.kilometerReading;
    if (mileage != null && mileage.isNotEmpty && mileage != '0') {
      features.add({'icon': Icons.speed_rounded, 'title': AppLocaleKey.km.tr(), 'value': mileage});
    }

    if (car.cylinder.isNotEmpty && car.cylinder != '0') {
      features.add({
        'icon': Icons.settings_rounded,
        'title': AppLocaleKey.cylinders.tr(),
        'value': car.cylinder,
      });
    }

    if (car.seatNo != 0) {
      features.add({
        'icon': Icons.event_seat_rounded,
        'title': AppLocaleKey.seats.tr(),
        'value': '${car.seatNo}',
      });
    }

    if (car.doorNo != 0) {
      features.add({
        'icon': Icons.meeting_room_rounded,
        'title': AppLocaleKey.doors.tr(),
        'value': '${car.doorNo}',
      });
    }

    if (car.fuelCapacity.isNotEmpty && car.fuelCapacity != '0') {
      features.add({
        'icon': Icons.local_gas_station_rounded,
        'title': AppLocaleKey.liter.tr(),
        'value': car.fuelCapacity,
      });
    }

    if (car.powerHourse.isNotEmpty && car.powerHourse != '0') {
      features.add({
        'icon': Icons.bolt_rounded,
        'title': AppLocaleKey.hp.tr(),
        'value': car.powerHourse,
      });
    }

    if (car.customsCardNo != null && car.customsCardNo!.isNotEmpty) {
      features.add({
        'icon': Icons.card_membership_rounded,
        'title': AppLocaleKey.customsCard.tr(),
        'value': car.customsCardNo!,
      });
    }

    if (features.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppLocaleKey.additionalFeatures.tr()),
        Gap(16.h),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final item = features[index];

            return _FeatureCard(icon: item['icon'], title: item['title'], value: item['value']);
          },
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _FeatureCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: (0.08))),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: (0.04)),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context).withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 22.sp, color: AppColor.primaryColor(context)),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bodyLarge(
              context,
            ).copyWith(fontWeight: FontWeight.w800, color: AppColor.blackTextColor(context)),
          ),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
