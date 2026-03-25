import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppColor {
  static Color primaryColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff0066FF),
      dark: const Color(0xff0066FF),
      listen: listen,
    );
  }

  static Color secondAppColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF1E293B), // Elevated dark slate for cards/nav
      dark: const Color(0xFF1E293B),
      listen: listen,
    );
  }

  static Color borderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffA6A6A6),
      dark: const Color(0xffA6A6A6),
      listen: listen,
    );
  }

  static Color scaffoldColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(
        0xFF0F172A,
      ), // Elegant, cool-toned light grey (CarSwitch style)
      dark: const Color(0xFF0F172A),
      listen: listen,
    );
  }

  static Color textFormFillColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF1E293B), // Dark textfield fill
      dark: const Color(0xFF1E293B),
      listen: listen,
    );
  }

  static Color hintColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffA6A6A6),
      dark: const Color(0xffA6A6A6),
      listen: listen,
    );
  }

  static Color darkTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFE2E8F0), // Light slate
      dark: const Color(0xFFE2E8F0),
      listen: listen,
    );
  }

  static Color greyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFA5A5A5),
      dark: const Color(0xFFA5A5A5),
      listen: listen,
    );
  }

  static Color titleFormFiledColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFF8FAFC), // Off-white for section titles
      dark: const Color(0xFFF8FAFC),
      listen: listen,
    );
  }

  static Color blackTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFFFFFFF), // Invert black to white for readability
      dark: const Color(0xFFFFFFFF),
      listen: listen,
    );
  }

  static Color whiteColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color textFormBorderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF334155), // Subtle dark border
      dark: const Color(0xFF334155),
      listen: listen,
    );
  }

  static Color textFormColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFFFFFFF), // Input text color
      dark: const Color(0xFFFFFFFF),
      listen: listen,
    );
  }

  static Color appBarTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFFFFFFF), // Appbar text color
      dark: const Color(0xFFFFFFFF),
      listen: listen,
    );
  }

  static Color appBarColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF0F172A), // Elevated dark slate for appbar
      dark: const Color(0xFF0F172A),
      listen: listen,
    );
  }

  static Color buttonTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }
}
