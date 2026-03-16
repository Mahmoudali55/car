import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
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
        const SectionTitleWidget(title: 'المواصفات الأساسية'),
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
              'سنة الموديل',
              car['year'] ?? 'N/A',
            ),
            _buildSpecItem(context, Icons.speed_rounded, 'الممشى', car['mileage'] ?? '0 كم'),
            _buildSpecItem(
              context,
              Icons.settings_input_component_rounded,
              'ناقل الحركة',
              'أوتوماتيك',
            ),
            _buildSpecItem(context, Icons.ev_station_rounded, 'نوع الوقود', 'بنزين 95'),
            _buildSpecItem(context, Icons.color_lens_rounded, 'اللون الخارجي', 'سماوي ميتاليك'),
            _buildSpecItem(context, Icons.airline_seat_recline_extra_rounded, 'السعة', '5 ركاب'),
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
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
                  ).copyWith(color: Colors.white.withValues(alpha: 0.4), fontSize: 10.sp),
                ),
                Text(
                  value,
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
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
