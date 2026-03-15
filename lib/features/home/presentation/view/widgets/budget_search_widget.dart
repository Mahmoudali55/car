import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetSearchWidget extends StatefulWidget {
  const BudgetSearchWidget({super.key});

  @override
  State<BudgetSearchWidget> createState() => _BudgetSearchWidgetState();
}

class _BudgetSearchWidgetState extends State<BudgetSearchWidget> {
  @override
  final budgets = [
    AppLocaleKey.under50k.tr(),
    AppLocaleKey.k50k100k.tr(),
    AppLocaleKey.k100k200k.tr(),
    AppLocaleKey.over200k.tr(),
  ];
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: budgets.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.1)),
            ),
            child: Center(
              child: Text(
                budgets[index],
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
