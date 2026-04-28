import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankInstallmentsBannerWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const BankInstallmentsBannerWidget({super.key, required this.car});

  String _getInstallmentPrice() {
    // Check multiple potential keys for installment price
    final price = car['installments'] ?? "1,999";
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.financingScreen, arguments: car);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.agentInstallments.tr(),
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Gap(6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _getInstallmentPrice(),
                style: AppTextStyle.titleMedium(context).copyWith(
                  color: AppColor.blueColor(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                ),
              ),
              Gap(4.w),
              Text(
                '${AppLocaleKey.aed.tr()} / ${AppLocaleKey.agentAppointment.tr() == "English" ? "Mo" : "شهرياً"}',
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.blueColor(context), fontSize: 10.sp),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.calculate_outlined, color: AppColor.blueColor(context), size: 14.sp),
              Gap(4.w),
              Text(
                AppLocaleKey.agentCalculateFinancing.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blueColor(context),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
