import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/mini_detail_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardContentSection extends StatelessWidget {
  const CardContentSection({required this.car, required this.onTap});

  final Map<String, dynamic> car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 300.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(16.h),
            Text(
              car['name']!,
              style: AppTextStyle.titleMedium(context).copyWith(
                color: AppColor.blackTextColor(context),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MiniDetailWidget(icon: Icons.calendar_today_outlined, label: car['year']!),
                MiniDetailWidget(icon: Icons.speed_outlined, label: car['mileage']!),
                MiniDetailWidget(icon: Icons.settings_outlined, label: car['engine']!),
              ],
            ),
            Gap(20.h),
            Text(
              '${car['price']!} ${AppLocaleKey.sar.tr()}',
              style: AppTextStyle.titleMedium(context).copyWith(
                color: AppColor.primaryColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 19.sp,
                fontFamily: 'Arial',
              ),
            ),
            Gap(20.h),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomButton(
                    radius: 12.r,
                    onPressed: onTap,
                    child: Text(
                      AppLocaleKey.orderNow.tr(),
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    onPressed: onTap,
                    color: AppColor.whiteColor(context),
                    radius: 12.r,
                    borderColor: AppColor.blackTextColor(context).withOpacity(0.1),
                    child: Text(
                      AppLocaleKey.details.tr(),
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.blackColor(context), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
