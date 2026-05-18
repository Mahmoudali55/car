import 'package:cached_network_image/cached_network_image.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/inventory_action_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quote_builder_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarInventoryCardWidget extends StatelessWidget {
  const CarInventoryCardWidget({super.key, required this.car});
  final Map<String, String> car;
  @override
  Widget build(BuildContext context) {
    final statusKey = car['status']!;
    final statusColor = statusKey == AppLocaleKey.adminCarStatusPublished
        ? AppColor.greenColor(context)
        : (statusKey == AppLocaleKey.adminCarStatusPending
              ? Colors.orangeAccent
              : AppColor.redColor(context));
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.r),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 160.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?q=80&w=500',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
                  ),
                ),
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColor.blackColor(context).withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.whiteColor(context).withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      car['year']!,
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      statusKey.tr(),
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.blackColor(context),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['name']!,
                              style: TextStyle(
                                color: AppColor.blackTextColor(context),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Gap(4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.speed_rounded,
                                  size: 14.sp,
                                  color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                                ),
                                Gap(4.w),
                                Text(
                                  car['mileage']!,
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            car['price']!,
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            AppLocaleKey.aed.tr(),
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      if (car['status'] == AppLocaleKey.adminCarStatusPublished) ...[
                        Gap(8.w),
                        Expanded(
                          child: InventoryActionWidget(
                            icon: Icons.description_outlined,
                            label: AppLocaleKey.generateQuote.tr(),
                            color: AppColor.primaryColor(context),
                            onTap: () {
                              QuoteBuilderDialog.show(
                                context,
                                carName: car['name']!,
                                initialPrice:
                                    double.tryParse(car['price']!.replaceAll(',', '')) ?? 0.0,
                                existingSpecs: {
                                  AppLocaleKey.manufacturingYear.tr(): car['year']!,
                                  AppLocaleKey.mileage.tr(): car['mileage']!,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                      Gap(8.w),
                      Expanded(
                        child: InventoryActionWidget(
                          icon: Icons.delete_sweep_rounded,
                          label: AppLocaleKey.delete.tr(),
                          color: AppColor.redColor(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
