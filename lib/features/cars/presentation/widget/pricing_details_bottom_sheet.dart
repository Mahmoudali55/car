import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PricingDetailsBottomSheet extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final double totalPrice;

  const PricingDetailsBottomSheet({super.key, required this.car, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final double registrationFee = 875.0;
    final double shippingFee = 225.0;
    final double serviceVat = (registrationFee + shippingFee) * 0.15;
    final double carValue = totalPrice - registrationFee - shippingFee - serviceVat;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocaleKey.showDetails.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w900, fontSize: 22.sp),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          Gap(24.h),
          Container(height: 1, color: AppColor.borderColor(context).withValues(alpha: 0.5)),
          Gap(24.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  car.itemName,
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900, fontSize: 18.sp),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: car.fullCarImage.startsWith('http')
                    ? CustomNetworkImage(
                        imageUrl: car.fullCarImage,
                        height: 80.h,
                        width: 120.w,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        car.fullCarImage.isEmpty
                            ? AppImages.assetsImagesPlaceholder
                            : car.fullCarImage,
                        height: 80.h,
                        width: 120.w,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          height: 80.h,
                          width: 120.w,
                          color: Colors.grey[200],
                          child: const Icon(Icons.car_repair),
                        ),
                      ),
              ),
            ],
          ),
          Gap(32.h),
          _buildPriceItem(AppLocaleKey.carValue.tr(), carValue.toStringAsFixed(2), context),
          Gap(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.carWarranty.tr(),
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocaleKey.warrantyDuration.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: Colors.grey, fontSize: 10.sp),
                  ),
                ],
              ),
              Text(
                AppLocaleKey.free.tr(),
                style: AppTextStyle.bodyLarge(context).copyWith(
                  color: const Color(0xff00c853),
                  fontWeight: FontWeight.w900,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Gap(24.h),
          _buildPriceItem(
            AppLocaleKey.registrationAndPlates.tr(),
            registrationFee.toInt().toString(),
            context,
          ),
          Gap(24.h),
          _buildPriceItem(AppLocaleKey.shippingCost.tr(), shippingFee.toInt().toString(), context),
          Gap(24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPriceItem(AppLocaleKey.serviceVat.tr(), serviceVat.toStringAsFixed(2), context),
              Gap(4.h),
              Text(
                AppLocaleKey.serviceVatDescription.tr(),

                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: Colors.grey, fontSize: 9.sp, height: 1.5),
              ),
            ],
          ),
          Gap(32.h),
          Gap(32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocaleKey.totalAmount.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w900, fontSize: 18.sp),
              ),
              Text(
                '${totalPrice.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}',
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w900, fontSize: 22.sp),
              ),
            ],
          ),
          Gap(24.h),
        ],
      ),
    );
  }

  Widget _buildPriceItem(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
            ),
            Gap(8.w),
            Icon(Icons.payments_outlined, color: AppColor.blackTextColor(context), size: 18.sp),
          ],
        ),
      ],
    );
  }
}
