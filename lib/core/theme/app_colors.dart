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
      light: const Color(0xFFFFFFFF), // White card/nav in light mode
      dark: const Color(0xFF1E293B), // Dark slate in dark mode
      listen: listen,
    );
  }

  static Color borderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFCBD5E1),
      dark: const Color(0xffA6A6A6),
      listen: listen,
    );
  }

  static Color scaffoldColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFF1F5F9), // Light grey in light mode
      dark: const Color(0xFF0F172A), // Deep dark navy in dark mode
      listen: listen,
    );
  }

  static Color textFormFillColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFF8FAFC),
      dark: const Color(0xFF1E293B),
      listen: listen,
    );
  }

  static Color hintColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF94A3B8),
      dark: const Color(0xffA6A6A6),
      listen: listen,
    );
  }

  static Color darkTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF1E293B),
      dark: const Color(0xFFE2E8F0),
      listen: listen,
    );
  }

  static Color greyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF64748B),
      dark: const Color(0xFFA5A5A5),
      listen: listen,
    );
  }

  static Color titleFormFiledColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF1E293B),
      dark: const Color(0xFFF8FAFC),
      listen: listen,
    );
  }

  static Color blackTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF0F172A), // Dark text in light mode
      dark: const Color(0xFFFFFFFF), // White text in dark mode
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
      light: const Color(0xFFCBD5E1),
      dark: const Color(0xFF334155),
      listen: listen,
    );
  }

  static Color textFormColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF0F172A), // Dark input text in light mode
      dark: const Color(0xFFFFFFFF),
      listen: listen,
    );
  }

  static Color appBarTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF0F172A),
      dark: const Color(0xFFFFFFFF),
      listen: listen,
    );
  }

  static Color appBarColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFFFFFFF),
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

  /// Card surface color — slightly elevated from scaffold
  static Color cardColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFFFFFFF),
      dark: const Color(0xFF1E293B),
      listen: listen,
    );
  }

  /// Divider / subtle separator color
  static Color dividerColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFE2E8F0),
      dark: const Color(0xFF334155),
      listen: listen,
    );
  }
}
