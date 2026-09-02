import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/customer_loan_application_model.dart';
import 'package:car/features/profile/presentation/screen/widget/financial_grid_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/tag_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoanApplicationCard extends StatelessWidget {
  const LoanApplicationCard({super.key, required this.application});
  final CustomerLoanApplicationModel application;

  String _getLocalizedStatus(int status, String defaultTxt) {
    switch (status) {
      case 0:
        return AppLocaleKey.loanPending.tr();
      case 1:
        return AppLocaleKey.loanApproved.tr();
      case 2:
        return AppLocaleKey.loanRejected.tr();
      default:
        return defaultTxt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(application.applicationStatus);
    final formatter = NumberFormat('#,##0.00', 'en_US');

    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                      ),
                      Gap(5.w),
                      Text(
                        _getLocalizedStatus(
                          application.applicationStatus,
                          application.applicationStatusTxt,
                        ),
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: statusColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${AppLocaleKey.applicationNumber.tr()}${application.applicationID}',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context)),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.directions_car_rounded,
                        color: AppColor.primaryColor(context),
                        size: 28.sp,
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            application.carName,
                            style: AppTextStyle.titleSmall(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(4.h),
                          Row(
                            children: [
                              Tag(
                                label: application.makeYear,
                                icon: Icons.calendar_today_rounded,
                                context: context,
                              ),
                              Gap(6.w),
                              Tag(
                                label: application.programName,
                                icon: Icons.account_balance_rounded,
                                context: context,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Gap(14.h),
                Divider(color: AppColor.dividerColor(context), height: 1),
                Gap(14.h),
                FinancialGrid(application: application, formatter: formatter),
                Gap(14.h),
                Divider(color: AppColor.dividerColor(context), height: 1),
                Gap(10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 14.sp,
                          color: AppColor.greyColor(context),
                        ),
                        Gap(4.w),
                        Text(
                          '${AppLocaleKey.applicationDate.tr()}${application.createdDate}',
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(color: AppColor.greyColor(context)),
                        ),
                      ],
                    ),
                    if (application.genderTxt.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.person_rounded,
                            size: 14.sp,
                            color: AppColor.greyColor(context),
                          ),
                          Gap(4.w),
                          Text(
                            application.genderTxt,
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: AppColor.greyColor(context)),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xFFF59E0B); // قيد المعالجة - amber
      case 1:
        return const Color(0xFF10B981); // مقبول - green
      case 2:
        return const Color(0xFFEF4444); // مرفوض - red
      default:
        return const Color(0xFF6B7280); // grey
    }
  }
}
