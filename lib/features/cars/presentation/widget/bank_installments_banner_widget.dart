import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankInstallmentsBannerWidget extends StatelessWidget {
  final GetBrandCarsDataModel car;

  const BankInstallmentsBannerWidget({super.key, required this.car});

  String _getInstallmentPrice() {
    final price = car.installments ?? "1,999";
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.financingScreen, arguments: car.toMap());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.agentInstallments.tr(),
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: AppColor.blueColor(context), fontWeight: FontWeight.bold),
          ),
          Gap(6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  _getInstallmentPrice(),
                  style: AppTextStyle.titleMedium(context).copyWith(
                    color: AppColor.blueColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Gap(4.w),
              Flexible(
                child: ValueWithCurrencyIcon(
                  text:
                      '${AppLocaleKey.aed.tr()} / ${AppLocaleKey.agentAppointment.tr() == "English" ? "Mo" : "شهرياً"}',
                  textStyle: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blueColor(context), fontSize: 10.sp),
                ),
              ),
            ],
          ),

          Gap(10.h),
          Container(
            height: 20.h,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.greyColor(context), width: 0.09.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.calculate_outlined, color: AppColor.blueColor(context), size: 14.sp),
                Gap(4.w),
                Expanded(
                  child: Text(
                    AppLocaleKey.agentCalculateFinancing.tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blueColor(context),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(4.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.primaryColor(context),
                  size: 12.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
