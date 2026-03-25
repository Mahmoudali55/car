import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondAppColor(context, listen: false),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocaleKey.settings.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildSectionHeader(context, AppLocaleKey.general.tr()),
          Gap(12.h),
          FadeInLeft(
            duration: const Duration(milliseconds: 400),
            child: _buildSettingItem(
              context,
              icon: Icons.language_rounded,
              title: AppLocaleKey.language.tr(),
              trailing: Text(
                context.locale.languageCode == 'ar'
                    ? AppLocaleKey.arabic.tr()
                    : AppLocaleKey.english.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.primaryColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _showLanguageDialog(context),
            ),
          ),
          Gap(24.h),
          _buildSectionHeader(context, AppLocaleKey.accountSecurity.tr()),
          Gap(12.h),
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 400),
            child: _buildSettingItem(
              context,
              icon: Icons.lock_outline_rounded,
              title: AppLocaleKey.changePassword.tr(),
              onTap: () {
                // TODO: Navigate to Change Password Screen
              },
            ),
          ),
          Gap(32.h),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: _buildLogoutButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyle.bodySmall(context).copyWith(
        color: Colors.white38,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColor.primaryColor(context).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColor.primaryColor(context), size: 22.sp),
        ),
        title: Text(
          title,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        trailing:
            trailing ??
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white24,
              size: 14.sp,
            ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.secondAppColor(context, listen: false),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocaleKey.language.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: Colors.white),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(
                  context,
                  listen: false,
                ).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColor.primaryColor(context, listen: false)
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColor.primaryColor(context),
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
          foregroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(color: Colors.redAccent, width: 0.5),
          ),
          elevation: 0,
        ),
        onPressed: () {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.loginScreen,
            (route) => false,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, size: 20.sp),
            Gap(12.w),
            Text(
              AppLocaleKey.logout.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
