import 'dart:io';

import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/services/permission_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class FinancingDocumentsTab extends StatefulWidget {
  const FinancingDocumentsTab({super.key});

  @override
  State<FinancingDocumentsTab> createState() => _FinancingDocumentsTabState();
}

class _FinancingDocumentsTabState extends State<FinancingDocumentsTab> {
  final Map<String, File?> uploadedFiles = {};

  // ─── Pickers ───────────────────────────────────────────────────────────────

  Future<void> _pickImageFromGallery(String key) async {
    final hasPermission = await PermissionService.requestPhotoPermission(context);
    if (!hasPermission) return;
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) setState(() => uploadedFiles[key] = File(image.path));
  }

  Future<void> _pickImageFromCamera(String key) async {
    final hasPermission = await PermissionService.requestPhotoPermission(context);
    if (!hasPermission) return;
    final image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 70);
    if (image != null) setState(() => uploadedFiles[key] = File(image.path));
  }

  Future<void> _pickPdfFile(String key) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() => uploadedFiles[key] = File(result.files.single.path!));
    }
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

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

  // ─── Requirements ──────────────────────────────────────────────────────────

  Widget _buildRequirementsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppLocaleKey.agentFinancingRequirements.tr(),
          style: AppTextStyle.titleSmall(context)
              .copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
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
                  color: AppColor.primaryColor(context).withValues(alpha: 0.1),
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
                style: AppTextStyle.bodySmall(context)
                    .copyWith(color: AppColor.greyColor(context), fontSize: 12.sp),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: AppColor.dividerColor(context),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }

  // ─── Documents checklist ───────────────────────────────────────────────────

  Widget _buildDocumentsSection(BuildContext context) {
    final docs = [
      AppLocaleKey.agentMinSalaryDoc.tr(),
      AppLocaleKey.agentNoSalaryTransfer.tr(),
      AppLocaleKey.agentEmployerNotApproved.tr(),
      AppLocaleKey.agentNoDownPaymentDoc.tr(),
      AppLocaleKey.agentLastPaymentDoc.tr(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.agentRequiredDocumentsList.tr(),
          style: AppTextStyle.titleSmall(context)
              .copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
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
          child: ValueWithCurrencyIcon(
            text: text,
            textStyle: AppTextStyle.bodyMedium(context)
                .copyWith(color: AppColor.blackTextColor(context), height: 1.4),
          ),
        ),
      ],
    );
  }

  // ─── Upload section ────────────────────────────────────────────────────────

  Widget _buildUploadSection(BuildContext context) {
    final uploadItems = [
      AppLocaleKey.agentNationalIdCopy.tr(),
      AppLocaleKey.agentDrivingLicenseCopy.tr(),
      AppLocaleKey.agentSalaryStatement.tr(),
      AppLocaleKey.customsCard.tr(),
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppLocaleKey.agentUploadDocuments.tr(),
            style: AppTextStyle.bodyMedium(context)
                .copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
          ),
          Gap(12.h),
          ...uploadItems.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildUploadTile(context, item),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadTile(BuildContext context, String label) {
    final file = uploadedFiles[label];
    final bool uploaded = file != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Label
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (uploaded) ...[
              Icon(Icons.check_circle_rounded, color: AppColor.greenColor(context), size: 16.sp),
              Gap(6.w),
            ],
            Flexible(
              child: Text(
                label,
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.blackTextColor(context),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),

        Gap(10.h),

        // Three inline choice buttons
        Row(
          children: [
            _UploadChoiceButton(
              icon: Icons.camera_alt_rounded,
              label: AppLocaleKey.camera.tr(),
              accentColor: AppColor.blueColor(context),
              onTap: () => _pickImageFromCamera(label),
            ),
            Gap(8.w),
            _UploadChoiceButton(
              icon: Icons.photo_library_rounded,
              label: AppLocaleKey.selectImage.tr(),
              accentColor: AppColor.primaryColor(context),
              onTap: () => _pickImageFromGallery(label),
            ),
            Gap(8.w),
            _UploadChoiceButton(
              icon: Icons.picture_as_pdf_rounded,
              label: AppLocaleKey.selectPDF.tr(),
              accentColor: AppColor.redColor(context),
              onTap: () => _pickPdfFile(label),
            ),
          ],
        ),

        // Uploaded file indicator
        if (uploaded) ...[
          Gap(8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.greenColor(context).withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.greenColor(context).withValues(alpha: 0.35)),
            ),
            child: Row(
              children: [
                Icon(
                  file.path.toLowerCase().endsWith('.pdf')
                      ? Icons.picture_as_pdf_rounded
                      : Icons.image_rounded,
                  color: AppColor.greenColor(context),
                  size: 16.sp,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    file.path.split('/').last,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.greenColor(context),
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
                Gap(6.w),
                GestureDetector(
                  onTap: () => setState(() => uploadedFiles[label] = null),
                  child: Icon(
                    Icons.close_rounded,
                    size: 16.sp,
                    color: AppColor.greyColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],

        Gap(12.h),
        Divider(height: 1, color: AppColor.dividerColor(context)),
      ],
    );
  }
}

// ─── Inline choice button ───────────────────────────────────────────────────

class _UploadChoiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;
  final VoidCallback onTap;

  const _UploadChoiceButton({
    required this.icon,
    required this.label,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: accentColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: accentColor, size: 22.sp),
              Gap(4.h),
              Text(
                label,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
