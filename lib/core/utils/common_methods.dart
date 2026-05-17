import 'package:bot_toast/bot_toast.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../services/services_locator.dart';

class CommonMethods {
  static Future<bool> hasConnection() async {
    var isConnected = await sl<InternetConnection>().hasInternetAccess;
    if (isConnected) {
      return true;
    } else {
      return false;
    }
  }

  static void showToast({
    required String message,
    String? title,
    String? icon,
    ToastType type = ToastType.success,
    Color? backgroundColor,
    Color? textColor,
    int seconds = 3,
  }) {
    BotToast.showCustomText(
      duration: Duration(seconds: seconds),
      toastBuilder: (cancelFunc) => CustomToast(
        type: type,
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        icon: icon,
        textColor: textColor,
      ),
    );
  }

  static void showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.secondAppColor(context, listen: false),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Icon(Icons.lock_person_rounded, color: AppColor.primaryColor(context), size: 28.sp),
            SizedBox(width: 10.w),
            Text(
              AppLocaleKey.loginRequired.tr(),
              style: AppTextStyle.titleMedium(
                context,
              ).copyWith(color: AppColor.blackTextColor(context)),
            ),
          ],
        ),
        content: Text(
          AppLocaleKey.loginToContinueYourPremiumExperience.tr(),
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.70)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocaleKey.cancel.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutesName.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor(context),
              foregroundColor: AppColor.blackTextColor(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text(
              AppLocaleKey.login.tr(),
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.bold, color: AppColor.whiteColor(context)),
            ),
          ),
        ],
      ),
    );
  }
}
