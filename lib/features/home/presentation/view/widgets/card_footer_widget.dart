import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/spec_badge_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardFooter extends StatelessWidget {
  const CardFooter({required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    final String? priceRaw = car['price']?.toString();
    final bool hasPrice =
        priceRaw != null && priceRaw != '0' && priceRaw.isNotEmpty && priceRaw != 'null';

    final String priceText = hasPrice ? '$priceRaw ${AppLocaleKey.sar.tr()}' : '0';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        border: Border(top: BorderSide(color: AppColor.blackTextColor(context).withOpacity(0.06))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(8.h),
          Text(
            car['name'] ?? '',
            style: AppTextStyle.titleMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(12.h),
          Text(
            priceText,
            style: AppTextStyle.titleMedium(context).copyWith(
              color: hasPrice ? AppColor.primaryColor(context) : AppColor.greyColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecBadgeWidget(
                icon: Icons.calendar_today_rounded,
                text: car['year']?.toString() ?? 'N/A',
              ),
              SpecBadgeWidget(icon: Icons.speed_rounded, text: car['mileage'] ?? '0 كم'),
              SpecBadgeWidget(icon: Icons.electric_bolt_rounded, text: car['engine'] ?? 'N/A'),
            ],
          ),
        ],
      ),
    );
  }
}
