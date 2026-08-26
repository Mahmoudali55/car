import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TermsSettingsScreen extends StatelessWidget {
  const TermsSettingsScreen({super.key});

  List<String> get _terms => List.generate(17, (index) => 'term_${index + 1}'.tr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.termsTitle.tr())),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),

            Gap(24.h),

            _buildImportantNotice(context),

            Gap(24.h),

            _buildSectionTitle(context),

            Gap(12.h),

            ...List.generate(
              _terms.length,
              (index) =>
                  _buildTermCard(context, number: index + 1, text: _terms[index], index: index),
            ),

            Gap(12.h),

            _buildTaxInfo(context),

            Gap(20.h),

            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    final primary = AppColor.primaryColor(context);
    final white = AppColor.whiteColor(context);

    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [primary, primary.withValues(alpha: 0.82)],
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                color: white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(Icons.gavel_rounded, color: white, size: 30.sp),
            ),

            Gap(16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.termsTitle.tr(),
                    style: AppTextStyle.bodyLarge(
                      context,
                    ).copyWith(color: white, fontSize: 19.sp, fontWeight: FontWeight.w800),
                  ),

                  Gap(5.h),

                  Text(
                    AppLocaleKey.termsSubtitle.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: white.withValues(alpha: 0.82), height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // IMPORTANT NOTICE
  // ============================================================

  Widget _buildImportantNotice(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);

    return FadeInRight(
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.22)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(9.w),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.info_outline_rounded, color: Colors.orange.shade700, size: 21.sp),
            ),

            Gap(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.termsNoticeTitle.tr(),
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: baseColor, fontWeight: FontWeight.w800),
                  ),

                  Gap(4.h),

                  Text(
                    AppLocaleKey.termsNoticeDescription.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: baseColor.withValues(alpha: 0.65), height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: AppColor.primaryColor(context),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),

        Gap(9.w),

        Expanded(
          child: Text(
            AppLocaleKey.termsSectionTitle.tr(),
            style: AppTextStyle.bodyLarge(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColor.primaryColor(context).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            AppLocaleKey.termsCount.tr(),
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TERM CARD
  // ============================================================

  Widget _buildTermCard(
    BuildContext context, {
    required int number,
    required String text,
    required int index,
  }) {
    final baseColor = AppColor.blackTextColor(context);
    final primary = AppColor.primaryColor(context);

    return FadeInUp(
      delay: Duration(milliseconds: 40 * index),
      duration: const Duration(milliseconds: 350),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.025),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: baseColor.withValues(alpha: 0.06)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: primary.withValues(alpha: 0.05),
            highlightColor: primary.withValues(alpha: 0.03),
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),

            childrenPadding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 18.h),

            leading: Container(
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '$number',
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: primary, fontWeight: FontWeight.w900),
              ),
            ),

            title: Text(
              '${AppLocaleKey.termNumber.tr()} $number',
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: baseColor, fontWeight: FontWeight.w700),
            ),

            subtitle: Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                _shortText(text),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: baseColor.withValues(alpha: 0.45)),
              ),
            ),

            children: [
              Align(
                alignment: context.locale.languageCode == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: baseColor.withValues(alpha: 0.025),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    text,
                    textAlign: context.locale.languageCode == 'ar'
                        ? TextAlign.right
                        : TextAlign.left,
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: baseColor.withValues(alpha: 0.78),
                      height: 1.8,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SHORT TEXT
  // ============================================================

  String _shortText(String text) {
    if (text.length <= 65) {
      return text;
    }

    return '${text.substring(0, 65)}...';
  }

  // ============================================================
  // TAX INFO
  // ============================================================

  Widget _buildTaxInfo(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    final primary = AppColor.primaryColor(context);

    return FadeInUp(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: primary.withValues(alpha: 0.12)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(11.w),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.receipt_long_rounded, color: primary, size: 23.sp),
            ),

            Gap(14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.taxNumber.tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: baseColor.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Gap(3.h),

                  Text(
                    '311073142900003',
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: baseColor, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),

            Icon(Icons.verified_rounded, color: AppColor.greenColor(context), size: 22.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          AppLocaleKey.termsFooter.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.45), height: 1.6),
        ),
      ),
    );
  }
}
