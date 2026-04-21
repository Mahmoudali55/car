import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturesGridWidget extends StatelessWidget {
  const FeaturesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.bluetooth_rounded, 'label': AppLocaleKey.bluetooth.tr()},
      {'icon': Icons.camera_alt_rounded, 'label': AppLocaleKey.camera360.tr()},
      {'icon': Icons.airline_seat_recline_extra_rounded, 'label': AppLocaleKey.leather.tr()},
      {'icon': Icons.navigation_rounded, 'label': AppLocaleKey.gpsMaps.tr()},
      {'icon': Icons.brightness_high_rounded, 'label': AppLocaleKey.sunroof.tr()},
      {'icon': Icons.speed_rounded, 'label': AppLocaleKey.cruiseControl.tr()},
    ];

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
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
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
