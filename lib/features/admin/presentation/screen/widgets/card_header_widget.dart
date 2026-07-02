import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_inventory_card.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardHeader extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final CarStatusConfig cfg;
  final bool showBadge;

  const CardHeader({super.key, required this.car, required this.cfg, this.showBadge = true});

  @override
  Widget build(BuildContext context) {
    final bool isReserved = car.carStatus == 2;
    final String? customer = car.customerName;
    final String? representative = car.reservedName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                car.itemName,
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackTextColor(context),
                  height: 1.3,
                ),
              ),
            ),
            if (showBadge) ...[
              Gap(8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: cfg.bg, borderRadius: BorderRadius.circular(20.r)),
                child: Text(
                  cfg.label.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(fontWeight: FontWeight.w500, color: cfg.textColor),
                ),
              ),
            ],
          ],
        ),
        if (isReserved && (customer != null || representative != null)) ...[
          Gap(6.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: cfg.bg.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: cfg.textColor.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (customer != null && customer.isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(Icons.person_outline_rounded, size: 14.sp, color: cfg.textColor),
                      Gap(6.w),
                      Expanded(
                        child: Text(
                          "${AppLocaleKey.clientDetails.tr()}: $customer",
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(color: cfg.textColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
                if (customer != null &&
                    customer.isNotEmpty &&
                    representative != null &&
                    representative.isNotEmpty)
                  Gap(4.h),
                if (representative != null && representative.isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(Icons.badge_outlined, size: 14.sp, color: cfg.textColor),
                      Gap(6.w),
                      Expanded(
                        child: Text(
                          "${AppLocaleKey.representative.tr()}: $representative",
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(color: cfg.textColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
