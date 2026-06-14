import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarFilterChips extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const CarFilterChips({super.key, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'key': 'available', 'label': AppLocaleKey.agentCarAvailable.tr()},
      {'key': 'reserved', 'label': AppLocaleKey.adminPendingApprovals.tr()},
      {'key': 'sold', 'label': AppLocaleKey.agentCarSold.tr()},
      {'key': 'returned', 'label': AppLocaleKey.horizontal.tr()},
    ];
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, i) {
          final f = filters[i];
          final isActive = selectedFilter == f['key'];
          return GestureDetector(
            onTap: () => onFilterChanged(f['key']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColor.primaryColor(context)
                    : AppColor.whiteColor(context).withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isActive
                      ? Colors.transparent
                      : AppColor.blackTextColor(context).withValues(alpha: 0.08),
                ),
              ),
              child: Center(
                child: Text(
                  f['label']!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? AppColor.whiteColor(context)
                        : AppColor.blackTextColor(context).withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
