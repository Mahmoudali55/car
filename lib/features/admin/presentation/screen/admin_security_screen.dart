import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminSecurityScreen extends StatelessWidget {
  const AdminSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.securityAndPrivacy.tr())),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSecurityHeader(context),
            Gap(32.h),
            _buildSecuritySection(context, AppLocaleKey.managePasswordsPermissions.tr(), [
              _buildSecurityItem(
                context,
                Icons.lock_outline_rounded,
                AppLocaleKey.password.tr(),
                AppLocaleKey.forgotPassword.tr(), // Placeholder description
                onTap: () {},
              ),
              _buildSecurityItem(
                context,
                Icons.fingerprint_rounded,
                AppLocaleKey.biometricAuth.tr(),
                AppLocaleKey.biometricAuthDesc.tr(),
                isSwitch: true,
              ),
              _buildSecurityItem(
                context,
                Icons.admin_panel_settings_rounded,
                "Role Permissions",
                "Configure administrative access levels",
                onTap: () {},
              ),
            ]),
            Gap(32.h),
            _buildSecuritySection(context, AppLocaleKey.privacyAndData.tr(), [
              _buildSecurityItem(
                context,
                Icons.visibility_off_rounded,
                AppLocaleKey.stealthMode.tr(),
                AppLocaleKey.stealthModeDesc.tr(),
                isSwitch: true,
              ),
              _buildSecurityItem(
                context,
                Icons.data_usage_rounded,
                AppLocaleKey.dataRetention.tr(),
                AppLocaleKey.dataRetentionDesc.tr(),
                onTap: () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader(BuildContext context) {
    return FadeInDown(
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor(context),
              AppColor.primaryColor(context).withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor(context).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_rounded, color: Colors.white, size: 32.sp),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.securityStatusLabel.tr(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    AppLocaleKey.highProtection.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
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

  Widget _buildSecuritySection(BuildContext context, String title, List<Widget> items) {
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

  Widget _buildSecurityItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
    bool isSwitch = false,
  }) {
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
          trailing: isSwitch
              ? Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: AppColor.primaryColor(context),
                )
              : Icon(Icons.chevron_left_rounded, color: baseColor.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}
