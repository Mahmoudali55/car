import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/language_option_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

void showLanguageDialog(BuildContext context) {
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
