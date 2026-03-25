import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../theme/theme_enum.dart';

class HiveMethods {
  static final _box = Hive.box('app');

  static String getLang() {
    return _box.get('lang', defaultValue: 'ar');
  }

  static void updateLang(Locale locale) {
    _box.put('lang', locale.languageCode);
  }

  static String? getToken() {
    return _box.get('token');
  }

  static void updateToken(String token) {
    _box.put('token', token);
  }

  static void deleteToken() {
    _box.delete('token');
  }

  static bool isFirstTime() {
    return _box.get('isFirstTime', defaultValue: true);
  }

  static void updateFirstTime() {
    _box.put('isFirstTime', false);
  }

  static ThemeEnum getTheme() {
    return _box.get('theme', defaultValue: ThemeEnum.light);
  }

  static void updateThem(ThemeEnum theme) {
    _box.put('theme', theme);
  }

  static List<dynamic> getFavorites() {
    return _box.get('favorites', defaultValue: []);
  }

  static void updateFavorites(List<dynamic> favorites) {
    _box.put('favorites', favorites);
  }

  static bool isGuest() {
    return _box.get('isGuest', defaultValue: false);
  }

  static void updateIsGuest(bool isGuest) {
    _box.put('isGuest', isGuest);
  }
}
