import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart' show AppColor;
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/quote_builder_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomQuoteHeaderWidget extends StatelessWidget {
  const CustomQuoteHeaderWidget({super.key, required this.widget});

  final QuoteBuilderDialog widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.description_rounded,
              color: AppColor.primaryColor(context),
              size: 24.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocaleKey.generateQuote.tr(),
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
                ),
                Text(
                  widget.car.itemName ?? '',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.5)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close_rounded,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
