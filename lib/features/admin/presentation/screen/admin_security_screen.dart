import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/security_Item_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/security_header_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/security_section_widget.dart';
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
            SecurityHeaderWidget(),
            Gap(32.h),
            SecuritySectionWidget(
              title: AppLocaleKey.managePasswordsPermissions.tr(),
              items: [
                SecurityItemWidget(
                  icon: Icons.lock_outline_rounded,
                  title: AppLocaleKey.password.tr(),
                  subtitle: AppLocaleKey.forgotPassword.tr(), // Placeholder description
                  onTap: () {},
                ),
                SecurityItemWidget(
                  icon: Icons.fingerprint_rounded,
                  title: AppLocaleKey.biometricAuth.tr(),
                  subtitle: AppLocaleKey.biometricAuthDesc.tr(),
                  isSwitch: true,
                ),
                SecurityItemWidget(
                  icon: Icons.admin_panel_settings_rounded,
                  title: "Role Permissions",
                  subtitle: "Configure administrative access levels",
                  onTap: () {},
                ),
              ],
            ),
            Gap(32.h),
            SecuritySectionWidget(
              title: AppLocaleKey.privacyAndData.tr(),
              items: [
                SecurityItemWidget(
                  icon: Icons.visibility_off_rounded,
                  title: AppLocaleKey.stealthMode.tr(),
                  subtitle: AppLocaleKey.stealthModeDesc.tr(),
                  isSwitch: true,
                ),
                SecurityItemWidget(
                  icon: Icons.data_usage_rounded,
                  title: AppLocaleKey.dataRetention.tr(),
                  subtitle: AppLocaleKey.dataRetentionDesc.tr(),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
