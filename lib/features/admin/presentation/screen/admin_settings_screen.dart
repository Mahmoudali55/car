import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
import 'package:car/features/admin/presentation/screen/widgets/logout_button_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/security_section_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/setting_Item_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/show_language_dialog_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/theme_toggle_Item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.adminSettings.tr())),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            bottom: -50.h,
            right: -50.w,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withValues(alpha: 0.02),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.02),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<AppThemeCubit, AppThemeState>(
              builder: (context, themeState) {
                final isDark = context.read<AppThemeCubit>().theme == ThemeEnum.dark;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SecuritySectionWidget(
                      title: AppLocaleKey.systemSettings.tr(),
                      items: [
                        ThemeToggleItem(isDark: isDark),
                        SettingItemWidget(
                          icon: Icons.security_rounded,
                          title: AppLocaleKey.securityAndPrivacy.tr(),
                          subtitle: AppLocaleKey.managePasswordsPermissions.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.securitySettings),
                        ),
                        SettingItemWidget(
                          icon: Icons.language_rounded,
                          title: AppLocaleKey.language.tr(),
                          subtitle: AppLocaleKey.appLanguageDesc.tr(),
                          onTap: () => showLanguageDialog(context),
                        ),
                        SettingItemWidget(
                          icon: Icons.notifications_active_rounded,
                          title: AppLocaleKey.systemAlerts.tr(),
                          subtitle: AppLocaleKey.systemNotificationsDesc.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.systemAlerts),
                        ),
                      ],
                    ),
                    Gap(32.h),
                    SecuritySectionWidget(
                      title: AppLocaleKey.contentManagement.tr(),
                      items: [
                        SettingItemWidget(
                          icon: Icons.category_rounded,
                          title: AppLocaleKey.categories.tr(),
                          subtitle: AppLocaleKey.manageCategoriesDesc.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.manageCategories),
                        ),
                        SettingItemWidget(
                          icon: Icons.discount_rounded,
                          title: AppLocaleKey.discountCoupons.tr(),
                          subtitle: AppLocaleKey.manageOffersDiscounts.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.discountCoupons),
                        ),
                        SettingItemWidget(
                          icon: Icons.policy_rounded,
                          title: AppLocaleKey.termsAndConditions.tr(),
                          subtitle: AppLocaleKey.updateUsagePolicies.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.termsSettings),
                        ),
                      ],
                    ),
                    Gap(32.h),
                    SecuritySectionWidget(
                      title: AppLocaleKey.technicalSupport.tr(),
                      items: [
                        SettingItemWidget(
                          icon: Icons.help_outline_rounded,
                          title: AppLocaleKey.supportCenter.tr(),
                          subtitle: AppLocaleKey.helpCenterDesc.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.adminSupport),
                        ),
                        SettingItemWidget(
                          icon: Icons.contact_support_outlined,
                          title: AppLocaleKey.contactDeveloper.tr(),
                          subtitle: AppLocaleKey.raiseSupportTicket.tr(),
                          onTap: () => Navigator.pushNamed(context, RoutesName.contactDeveloper),
                        ),
                      ],
                    ),
                    Gap(40.h),
                    LogoutButtonWidget(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
