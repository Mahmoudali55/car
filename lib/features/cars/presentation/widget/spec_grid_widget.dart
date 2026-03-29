import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SpecGridWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const SpecGridWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppLocaleKey.basicFeatures.tr()),
        Gap(16.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          children: [
            _buildSpecItem(
              context,
              Icons.calendar_today_rounded,
              AppLocaleKey.modelYear.tr(),
              car['year'] ?? 'N/A',
            ),
            _buildSpecItem(
              context,
              Icons.speed_rounded,
              AppLocaleKey.mileage.tr(),
              car['mileage'] ?? '0 ${AppLocaleKey.km.tr()}',
            ),
            _buildSpecItem(
              context,
              Icons.settings_input_component_rounded,
              AppLocaleKey.transmission.tr(),
              AppLocaleKey.normal.tr(),
            ),
            _buildSpecItem(
              context,
              Icons.ev_station_rounded,
              AppLocaleKey.fuelTypeLabel.tr(),
              AppLocaleKey.petrol95.tr(),
            ),
            _buildSpecItem(
              context,
              Icons.color_lens_rounded,
              AppLocaleKey.exteriorColor.tr(),
              AppLocaleKey.skyBlueMetallic.tr(),
            ),
            _buildSpecItem(
              context,
              Icons.airline_seat_recline_extra_rounded,
              AppLocaleKey.capacity.tr(),
              AppLocaleKey.fivePassengers.tr(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecItem(BuildContext context, IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context)),
                ),
                Text(
                  value,
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
