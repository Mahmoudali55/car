import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TermsSettingsScreen extends StatelessWidget {
  const TermsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.termsAndConditions.tr())),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColor.primaryColor(context),
        icon: const Icon(Icons.edit_rounded, color: Colors.white),
        label: Text(
          AppLocaleKey.editPolicies.tr(),
          style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComplianceHeader(context),
            Gap(32.h),
            _buildPolicySection(context, AppLocaleKey.systemPolicies.tr(), [
              _buildPolicyItem(
                context,
                Icons.gavel_rounded,
                "Terms of Service",
                "Last updated: Mar 15, 2024",
                () {},
              ),
              _buildPolicyItem(
                context,
                Icons.privacy_tip_rounded,
                "Privacy Policy",
                "Last updated: Feb 20, 2024",
                () {},
              ),
              _buildPolicyItem(
                context,
                Icons.assignment_return_rounded,
                "Return & Refund Policy",
                "Last updated: Jan 10, 2024",
                () {},
              ),
            ]),
            Gap(32.h),
            _buildPolicySection(context, AppLocaleKey.legalDocuments.tr(), [
              _buildPolicyItem(
                context,
                Icons.description_rounded,
                "Cookie Policy",
                "Version 2.1.0",
                () {},
              ),
              _buildPolicyItem(
                context,
                Icons.security_update_warning_rounded,
                "Security Disclaimers",
                "Version 1.4.5",
                () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceHeader(BuildContext context) {
    return FadeInDown(
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.verified_user_rounded, color: Colors.greenAccent, size: 28.sp),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.legalCompliance.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "All policies are up to date with regional regulations.",
                    style: TextStyle(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(BuildContext context, String title, List<Widget> items) {
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

  Widget _buildPolicyItem(
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
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: baseColor.withValues(alpha: 0.1), size: 14.sp),
        ),
      ),
    );
  }
}
