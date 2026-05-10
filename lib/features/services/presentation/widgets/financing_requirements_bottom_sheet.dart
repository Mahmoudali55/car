import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingRequirementsBottomSheet extends StatelessWidget {
  const FinancingRequirementsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocaleKey.agentCalculateFinancingAmount.tr(),
                    style: AppTextStyle.titleMedium(context).copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                      color: AppColor.primaryColor(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColor.borderColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16.sp, color: AppColor.blackTextColor(context)),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Financing requirements section
                  Text(
                    AppLocaleKey.agentFinancingRequirements.tr(),
                    style: AppTextStyle.titleSmall(context).copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.cardColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.borderColor(context)),
                    ),
                    child: Column(
                      children: [
                        _buildRequirementRow(
                          context,
                          icon: Icons.person_outline_rounded,
                          title: AppLocaleKey.agentCustomerAge.tr(),
                          value: AppLocaleKey.agentCustomerAgeLimit.tr(),
                          isLast: false,
                        ),
                        _buildRequirementRow(
                          context,
                          icon: Icons.credit_card_rounded,
                          title: AppLocaleKey.agentDrivingLicense.tr(),
                          value: AppLocaleKey.agentValidLicense.tr(),
                          isLast: false,
                        ),
                        _buildRequirementRow(
                          context,
                          icon: Icons.receipt_long_rounded,
                          title: AppLocaleKey.agentTrafficViolations.tr(),
                          value: AppLocaleKey.agentNoViolations.tr(),
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  Gap(24.h),
                  // Required documents section
                  Text(
                    AppLocaleKey.agentRequiredDocumentsList.tr(),
                    style: AppTextStyle.titleSmall(context).copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Gap(16.h),
                  _buildDocumentItem(context, AppLocaleKey.agentMinSalaryDoc.tr()),
                  Gap(12.h),
                  _buildDocumentItem(context, AppLocaleKey.agentNoSalaryTransfer.tr()),
                  Gap(12.h),
                  _buildDocumentItem(context, AppLocaleKey.agentEmployerNotApproved.tr()),
                  Gap(12.h),
                  _buildDocumentItem(context, AppLocaleKey.agentNoDownPaymentDoc.tr()),
                  Gap(12.h),
                  _buildDocumentItem(context, AppLocaleKey.agentLastPaymentDoc.tr()),
                  Gap(24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isLast,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
              ),
              Gap(12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w700, color: AppColor.blackTextColor(context)),
                ),
              ),
              Text(
                value,
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontSize: 12.sp),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: AppColor.dividerColor(context), indent: 16.w, endIndent: 16.w),
      ],
    );
  }

  Widget _buildDocumentItem(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, color: AppColor.greenColor(context), size: 20.sp),
        Gap(10.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), height: 1.4),
          ),
        ),
      ],
    );
  }
}
