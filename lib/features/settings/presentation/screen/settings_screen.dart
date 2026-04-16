import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
import 'package:car/features/admin/presentation/screen/widgets/language_option_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/logout_button_widget.dart';
import 'package:car/features/settings/presentation/screen/widget/section_header_widget.dart';
import 'package:car/features/settings/presentation/screen/widget/setting_items_widget.dart';
import 'package:car/features/settings/presentation/screen/widget/theme_toggle_widget.dart';
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
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.settings.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, themeState) {
          final isDark = context.read<AppThemeCubit>().theme == ThemeEnum.dark;
          return ListView(
            padding: EdgeInsets.all(20.w),
            children: [
              SectionHeaderWidget(title: AppLocaleKey.appearance.tr()),
              Gap(12.h),
              FadeInLeft(
                duration: const Duration(milliseconds: 300),
                child: ThemeToggleWidget(isDark: isDark),
              ),
              Gap(24.h),
              SectionHeaderWidget(title:  AppLocaleKey.general.tr()),
              Gap(12.h),
              FadeInLeft(
                duration: const Duration(milliseconds: 400),
                child: SettingItemsWidget(
                  
                  icon: Icons.language_rounded,
                  title: AppLocaleKey.language.tr(),
                  trailing: Text(
                    context.locale.languageCode == 'ar'
                        ? AppLocaleKey.arabic.tr()
                        : AppLocaleKey.english.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
                  ),
                  onTap: () => _showLanguageDialog(context),
                ),
              ),
              Gap(24.h),
              FadeInLeft(
                duration: const Duration(milliseconds: 450),
                child: SettingItemsWidget(
                  
                  icon: Icons.help_outline_rounded,
                  title: AppLocaleKey.faqs.tr(),
                  onTap: () => Navigator.pushNamed(context, RoutesName.faqScreen),
                ),
              ),
              Gap(24.h),
              SectionHeaderWidget(title: AppLocaleKey.accountSecurity.tr()),
              Gap(12.h),
              FadeInLeft(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 400),
                child: SettingItemsWidget(
                 
                  icon: Icons.lock_outline_rounded,
                  title: AppLocaleKey.changePassword.tr(),
                  onTap: () {},
                ),
              ),
              Gap(32.h),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: const LogoutButtonWidget(),
              ),
            ],
          );
        },
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
                LanguageOptionWidget(
                 
                  title: 'العربية',
                  isSelected: context.locale.languageCode == 'ar',
                  onTap: () async {
                    await context.setLocale(const Locale('ar'));
                    HiveMethods.updateLang(const Locale('ar'));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
                Gap(12.h),
                LanguageOptionWidget(
                  
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
}
