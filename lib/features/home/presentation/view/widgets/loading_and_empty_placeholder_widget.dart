import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: const Center(child: CustomLoading()),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.car_rental_rounded,
            size: 80.sp,
            color: AppColor.greyColor(context).withValues(alpha: (0.3)),
          ),
          Gap(5.h),
          Text(
            AppLocaleKey.agentNoCars.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
