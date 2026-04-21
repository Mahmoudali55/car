import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeToggleItem extends StatelessWidget {
  const ThemeToggleItem({super.key, required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
              color: baseColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
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
            style: TextStyle(color: baseColor.withOpacity(0.4), fontSize: 11.sp),
          ),
          trailing: Switch(
            value: isDark,
            activeThumbColor: AppColor.primaryColor(context),
            onChanged: (val) {
              context.read<AppThemeCubit>().theme = val ? ThemeEnum.dark : ThemeEnum.light;
            },
          ),
        ),
      ),
    );
  }
}
