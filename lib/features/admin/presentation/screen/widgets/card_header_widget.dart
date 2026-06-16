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
    return Row(
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
    );
  }
}
