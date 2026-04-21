import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key, required this.isDark});
final  bool isDark;
  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return Container(
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: baseColor.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColor.primaryColor(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              key: ValueKey(isDark),
              color: AppColor.primaryColor(context),
              size: 22.sp,
            ),
          ),
        ),
        title: Text(
          isDark ? AppLocaleKey.darkMode.tr() : AppLocaleKey.lightMode.tr(),
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: baseColor, fontWeight: FontWeight.w500),
        ),
        trailing: Switch(
          value: isDark,
          activeThumbColor: AppColor.primaryColor(context),
          onChanged: (val) {
            context.read<AppThemeCubit>().theme = val ? ThemeEnum.dark : ThemeEnum.light;
          },
        ),
      ),
    );
  }
}