import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumThemeToggle extends StatelessWidget {
  const PremiumThemeToggle({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        final cubit = context.read<AppThemeCubit>();
        final isDark = Theme.of(context).brightness == Brightness.dark;
        
        return GestureDetector(
          onTap: () {
            cubit.theme = isDark ? ThemeEnum.light : ThemeEnum.dark;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutBack,
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColor.cardColor(context).withOpacity(0.4),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: AppColor.blueColor(context).withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.blueColor(context).withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedRotation(
                  turns: isDark ? 0.5 : 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Icon(
                      isDark ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded,
                      key: ValueKey(isDark),
                      color: isDark ? AppColor.blueColor(context) : const Color(0xFFFBBF24),
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
