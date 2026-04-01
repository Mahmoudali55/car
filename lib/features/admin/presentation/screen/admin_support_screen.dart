import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminSupportScreen extends StatelessWidget {
  const AdminSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.supportCenter.tr())),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSupportHero(context),
            Gap(32.h),
            _buildSupportSection(context, AppLocaleKey.adminGuides.tr(), [
              _buildSupportTile(
                context,
                Icons.menu_book_rounded,
                AppLocaleKey.dashboardOverview.tr(),
                AppLocaleKey.dashboardOverviewDesc.tr(),
                () {},
              ),
              _buildSupportTile(
                context,
                Icons.manage_accounts_rounded,
                AppLocaleKey.userManagementGuide.tr(),
                AppLocaleKey.userManagementGuideDesc.tr(),
                () {},
              ),
              _buildSupportTile(
                context,
                Icons.inventory_rounded,
                AppLocaleKey.inventoryControl.tr(),
                AppLocaleKey.inventoryControlDesc.tr(),
                () {},
              ),
            ]),
            Gap(32.h),
            _buildSupportSection(context, AppLocaleKey.commonQuestions.tr(), [
              _buildFAQItem(context, AppLocaleKey.faqSellersRequest.tr(), AppLocaleKey.faqSellersRequestAns.tr()),
              _buildFAQItem(context, AppLocaleKey.faqAdminPassword.tr(), AppLocaleKey.faqAdminPasswordAns.tr()),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportHero(BuildContext context) {
    return FadeInDown(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: AppColor.primaryColor(context).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.help_center_rounded, color: AppColor.primaryColor(context), size: 32.sp),
            ),
            Gap(20.h),
            Text(
              AppLocaleKey.adminHelpHero.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h),
            Text(
              AppLocaleKey.adminHelpDesc.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(16.h),
        ...items,
      ],
    );
  }

  Widget _buildSupportTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: baseColor.withValues(alpha: 0.05)),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          leading: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: baseColor.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: baseColor, size: 22.sp),
          ),
          title: Text(
            title,
            style: TextStyle(color: baseColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: baseColor.withValues(alpha: 0.4), fontSize: 11.sp),
          ),
          trailing: Icon(Icons.arrow_forward_rounded, color: baseColor.withValues(alpha: 0.1), size: 18.sp),
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(color: baseColor, fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Gap(8.h),
            Text(
              answer,
              style: TextStyle(color: baseColor.withValues(alpha: 0.5), fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
