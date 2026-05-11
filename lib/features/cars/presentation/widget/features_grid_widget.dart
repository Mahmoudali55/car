import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturesGridWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const FeaturesGridWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [];

    final mileage = car['KILOMETER_READING'] ?? car['kilometerReading'];
    if (mileage != null && mileage.toString().isNotEmpty && mileage.toString() != '0') {
      features.add({'icon': Icons.speed_rounded, 'label': '$mileage ${AppLocaleKey.km.tr()}'});
    }

    final cylinder = car['CYLINDER'] ?? car['cylinder'];
    if (cylinder != null && cylinder.toString().isNotEmpty && cylinder.toString() != '0') {
      features.add({
        'icon': Icons.settings_applications_rounded,
        'label': '$cylinder ${AppLocaleKey.cylinders.tr()}',
      });
    }

    final seatNo = car['SEAT_NO'] ?? car['seatNo'];
    if (seatNo != null && seatNo.toString().isNotEmpty && seatNo.toString() != '0') {
      features.add({
        'icon': Icons.airline_seat_recline_extra_rounded,
        'label': '$seatNo ${AppLocaleKey.seats.tr()}',
      });
    }

    final doorNo = car['DOOR_NO'] ?? car['doorNo'];
    if (doorNo != null && doorNo.toString().isNotEmpty && doorNo.toString() != '0') {
      features.add({
        'icon': Icons.meeting_room_rounded,
        'label': '$doorNo ${AppLocaleKey.doors.tr()}',
      });
    }

    final fuelCapacity = car['FUEL_CAPACITY'] ?? car['fuelCapacity'];
    if (fuelCapacity != null &&
        fuelCapacity.toString().isNotEmpty &&
        fuelCapacity.toString() != '0') {
      features.add({
        'icon': Icons.local_gas_station_rounded,
        'label': '$fuelCapacity ${AppLocaleKey.liter.tr()}',
      });
    }

    final powerHourse = car['POWER_HOURSE'] ?? car['powerHourse'];
    if (powerHourse != null && powerHourse.toString().isNotEmpty && powerHourse.toString() != '0') {
      features.add({'icon': Icons.bolt_rounded, 'label': '$powerHourse ${AppLocaleKey.hp.tr()}'});
    }

    if (features.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppLocaleKey.additionalFeatures.tr()),
        Gap(16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: features.map((f) => _buildFeatureItem(context, f['icon'], f['label'])).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.05))),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
          Gap(10.w),
          Text(
            label,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
