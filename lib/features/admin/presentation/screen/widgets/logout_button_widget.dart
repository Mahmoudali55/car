import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.redAccent.withOpacity(0.1)),
        ),
        child: ListTile(
          onTap: () {
            HiveMethods.deleteToken();
            HiveMethods.updateRole('user');
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.loginScreen, (route) => false);
          },
          leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
          title: Text(
            AppLocaleKey.logout.tr(),
            style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.chevron_left_rounded, color: Colors.redAccent),
        ),
      ),
    );
  }
}
