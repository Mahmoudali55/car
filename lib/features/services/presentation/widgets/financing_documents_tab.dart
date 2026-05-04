import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingDocumentsTab extends StatelessWidget {
  const FinancingDocumentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildRequirementsSection(context),
          Gap(24.h),
          _buildDocumentsSection(context),
          Gap(24.h),
          _buildUploadSection(context),
          Gap(16.h),
        ],
      ),
    );
  }

  // ─── Requirements ─────────────────────────────────────────────────

  Widget _buildRequirementsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppLocaleKey.agentFinancingRequirements.tr(),
          style: AppTextStyle.titleSmall(
            context,
          ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
        ),
        Gap(14.h),
        Container(
          width: double.infinity,
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
      ],
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
                  style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w700),
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

  // ─── Documents List ───────────────────────────────────────────────

  Widget _buildDocumentsSection(BuildContext context) {
    final docs = [
      AppLocaleKey.agentMinSalaryDoc.tr(),
      AppLocaleKey.agentNoSalaryTransfer.tr(),
      AppLocaleKey.agentEmployerNotApproved.tr(),
      AppLocaleKey.agentNoDownPaymentDoc.tr(),
      AppLocaleKey.agentLastPaymentDoc.tr(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppLocaleKey.agentRequiredDocumentsList.tr(),
          style: AppTextStyle.titleSmall(
            context,
          ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
        ),
        Gap(14.h),
        ...docs.map(
          (doc) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildDocItem(context, doc),
          ),
        ),
      ],
    );
  }

  Widget _buildDocItem(BuildContext context, String text) {
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
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  // ─── Upload Section ───────────────────────────────────────────────

  Widget _buildUploadSection(BuildContext context) {
    final uploadItems = [
      AppLocaleKey.agentNationalIdCopy.tr(),
      AppLocaleKey.agentDrivingLicenseCopy.tr(),
      AppLocaleKey.agentSalaryStatement.tr(),
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppLocaleKey.agentUploadDocuments.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
          ),
          Gap(12.h),
          ...uploadItems.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _buildUploadTile(context, item),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadTile(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(context),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          children: [
            Icon(Icons.upload_file_outlined, color: AppColor.primaryColor(context), size: 20.sp),
            Gap(10.w),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context)),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
