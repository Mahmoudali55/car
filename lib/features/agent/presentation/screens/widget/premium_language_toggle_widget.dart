import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumLanguageToggle extends StatelessWidget {
  const PremiumLanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    
    return GestureDetector(
      onTap: () {
        final newLocale = isArabic ? const Locale('en') : const Locale('ar');
        context.setLocale(newLocale);
        HiveMethods.updateLang(newLocale);
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
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              isArabic ? 'EN' : 'AR',
              key: ValueKey(isArabic),
              style: TextStyle(
                color: AppColor.blueColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
