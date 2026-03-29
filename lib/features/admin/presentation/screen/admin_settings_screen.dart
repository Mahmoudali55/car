import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
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
                    _buildSection(context, AppLocaleKey.systemSettings.tr(), [
                      _buildThemeToggleItem(context, isDark),
                      _buildSettingItem(
                        context,
                        Icons.security_rounded,
                        AppLocaleKey.securityAndPrivacy.tr(),
                        AppLocaleKey.managePasswordsPermissions.tr(),
                      ),
                      _buildSettingItem(
                        context,
                        Icons.language_rounded,
                        AppLocaleKey.language.tr(),
                        AppLocaleKey.appLanguageDesc.tr(),
                        onTap: () => _showLanguageDialog(context),
                      ),
                      _buildSettingItem(
                        context,
                        Icons.notifications_active_rounded,
                        AppLocaleKey.systemAlerts.tr(),
                        AppLocaleKey.systemNotificationsDesc.tr(),
                      ),
                    ]),
                    Gap(32.h),
                    _buildSection(context, AppLocaleKey.contentManagement.tr(), [
                      _buildSettingItem(
                        context,
                        Icons.category_rounded,
                        AppLocaleKey.categories.tr(),
                        AppLocaleKey.manageCategoriesDesc.tr(),
                      ),
                      _buildSettingItem(
                        context,
                        Icons.discount_rounded,
                        AppLocaleKey.discountCoupons.tr(),
                        AppLocaleKey.manageOffersDiscounts.tr(),
                      ),
                      _buildSettingItem(
                        context,
                        Icons.policy_rounded,
                        AppLocaleKey.termsAndConditions.tr(),
                        AppLocaleKey.updateUsagePolicies.tr(),
                      ),
                    ]),
                    Gap(32.h),
                    _buildSection(context, AppLocaleKey.technicalSupport.tr(), [
                      _buildSettingItem(
                        context,
                        Icons.help_outline_rounded,
                        AppLocaleKey.supportCenter.tr(),
                        AppLocaleKey.helpCenterDesc.tr(),
                      ),
                      _buildSettingItem(
                        context,
                        Icons.contact_support_outlined,
                        AppLocaleKey.contactDeveloper.tr(),
                        AppLocaleKey.raiseSupportTicket.tr(),
                      ),
                    ]),
                    Gap(40.h),
                    _buildLogoutButton(context),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
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

  Widget _buildThemeToggleItem(BuildContext context, bool isDark) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: baseColor.withOpacity(0.05)),
        ),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: baseColor.withOpacity(0.05), shape: BoxShape.circle),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                key: ValueKey(isDark),
                color: baseColor,
                size: 20.sp,
              ),
            ),
          ),
          title: Text(
            AppLocaleKey.appearance.tr(),
            style: TextStyle(color: baseColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            isDark ? AppLocaleKey.darkMode.tr() : AppLocaleKey.lightMode.tr(),
            style: TextStyle(color: baseColor.withValues(alpha: 0.4), fontSize: 11.sp),
          ),
          trailing: Switch(
            value: isDark,
            activeColor: AppColor.primaryColor(context),
            onChanged: (val) {
              context.read<AppThemeCubit>().theme = val ? ThemeEnum.dark : ThemeEnum.light;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: baseColor.withOpacity(0.05)),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: baseColor.withOpacity(0.05), shape: BoxShape.circle),
            child: Icon(icon, color: baseColor, size: 20.sp),
          ),
          title: Text(
            title,
            style: TextStyle(color: baseColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: baseColor.withValues(alpha: 0.4), fontSize: 11.sp),
          ),
          trailing: Icon(Icons.chevron_left_rounded, color: baseColor.withValues(alpha: 0.2)),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.secondAppColor(ctx),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocaleKey.language.tr(),
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context)),
                ),
                Gap(20.h),
                _buildLanguageOption(
                  context,
                  title: 'العربية',
                  isSelected: context.locale.languageCode == 'ar',
                  onTap: () async {
                    await context.setLocale(const Locale('ar'));
                    HiveMethods.updateLang(const Locale('ar'));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
                Gap(12.h),
                _buildLanguageOption(
                  context,
                  title: 'English',
                  isSelected: context.locale.languageCode == 'en',
                  onTap: () async {
                    await context.setLocale(const Locale('en'));
                    HiveMethods.updateLang(const Locale('en'));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
                Gap(20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final baseColor = AppColor.blackTextColor(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context).withValues(alpha: 0.1)
              : baseColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor(context) : baseColor.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: baseColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: AppColor.primaryColor(context), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.1)),
        ),
        child: ListTile(
          onTap: () {},
          leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
          title: Text(
            AppLocaleKey.logout.tr(),
            style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.chevron_left_rounded, color: Colors.redAccent),
        ),
      ),
    );
  }
}
