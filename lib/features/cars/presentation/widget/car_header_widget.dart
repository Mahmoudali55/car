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
    final bool isInCompare = HiveMethods.isInComparison(widget.car['name'] ?? '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
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
            ),
            IconButton(
              onPressed: () {
                if (isInCompare) {
                  HiveMethods.removeFromComparison(widget.car['name'] ?? '');
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocaleKey.removeFromCompare.tr()),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      backgroundColor: AppColor.primaryColor(context, listen: false),
                    ),
                  );
                } else {
                  bool added = HiveMethods.addToComparison(widget.car);
                  if (added) {
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocaleKey.added_to_compare.tr()),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        backgroundColor: AppColor.primaryColor(context, listen: false),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocaleKey.compare_list_full.tr()),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        backgroundColor: AppColor.redColor(context, listen: false),
                      ),
                    );
                  }
                }
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
        Gap(16.h),
        // Consolidated Pricing Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.car['price'] ?? widget.car['cashPrice'] ?? '0',
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocaleKey.taxIncluded.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.6), fontSize: 10.sp),
                ),
              ],
            ),
            const Spacer(),
            if (widget.car['installments'] != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocaleKey.installments.tr(),
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      widget.car['installments'],
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
