import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarHeaderWidget extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarHeaderWidget({super.key, required this.car});

  @override
  State<CarHeaderWidget> createState() => _CarHeaderWidgetState();
}

class _CarHeaderWidgetState extends State<CarHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isInCompare = HiveMethods.isInComparison(widget.car['name']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.car['brand'] ?? '').toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                Gap(4.h),
                Text(
                  widget.car['name'] ?? '',
                  style: AppTextStyle.titleLarge(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                if (isInCompare) {
                  HiveMethods.removeFromComparison(widget.car['name']);
                } else {
                  HiveMethods.addToComparison(widget.car);
                }
                setState(() {});
                
                // Show a premium snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isInCompare 
                        ? AppLocaleKey.removeFromCompare.tr() 
                        : AppLocaleKey.added_to_compare.tr()
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: AppColor.primaryColor(context),
                  ),
                );
              },
              icon: Icon(
                isInCompare ? Icons.compare_arrows_rounded : Icons.add_chart_rounded,
                color: isInCompare ? AppColor.primaryColor(context) : AppColor.greyColor(context),
                size: 28.sp,
              ),
              tooltip: isInCompare 
                ? AppLocaleKey.removeFromCompare.tr() 
                : AppLocaleKey.addToCompare.tr(),
            ),
          ],
        ),
        Gap(10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.car['price'] ?? '0',
              style: AppTextStyle.titleMedium(
                context,
              ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
            ),
            Gap(8.w),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Text(
                AppLocaleKey.taxIncluded.tr(),
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.6)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
