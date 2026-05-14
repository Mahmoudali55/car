import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TransactionsListWidget extends StatelessWidget {
  const TransactionsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (index == 0 ? Colors.green : Colors.blue).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  index == 0 ? Icons.add_rounded : Icons.history_rounded,
                  color: index == 0 ? Colors.green : Colors.blue,
                  size: 20.sp,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0 ? 'Toyota Land Cruiser Sale' : 'Premium Listing Fee',
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '24 March 2024',
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                index == 0 ? '+450,000 ${AppLocaleKey.aed.tr()}' : '+299 ${AppLocaleKey.aed.tr()}',
                style: TextStyle(
                  color: index == 0 ? Colors.green : AppColor.blackTextColor(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
