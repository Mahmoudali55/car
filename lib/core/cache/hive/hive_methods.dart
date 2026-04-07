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
    return _box.get('theme', defaultValue: ThemeEnum.system);
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

  static String getRole() {
    return _box.get('role', defaultValue: 'user');
  }

  static void updateRole(String role) {
    _box.put('role', role);
  }

  // ─── Comparison List ────────────────────────────────────────
  static List<dynamic> getComparisonList() {
    return _box.get('comparisonList', defaultValue: []);
  }

  static void addToComparison(Map<String, dynamic> car) {
    final List<dynamic> list = List.from(getComparisonList());
    if (list.length >= 3) {
      // Keep only the latest 3
      list.removeLast();
    }
    // Avoid duplicates
    list.removeWhere((c) => c['name'] == car['name']);
    list.insert(0, car);
    _box.put('comparisonList', list);
  }

  static void removeFromComparison(String carName) {
    final List<dynamic> list = List.from(getComparisonList());
    list.removeWhere((c) => c['name'] == carName);
    _box.put('comparisonList', list);
  }

  static void clearComparisonList() {
    _box.put('comparisonList', []);
  }

  static bool isInComparison(String carName) {
    return getComparisonList().any((c) => c['name'] == carName);
  }

  // ─── Recently Viewed ────────────────────────────────────────
  static List<dynamic> getRecentlyViewed() {
    return _box.get('recentlyViewed', defaultValue: []);
  }

  static void addToRecentlyViewed(Map<String, dynamic> car) {
    final List<dynamic> list = List.from(getRecentlyViewed());
    // Remove if exists to move it to the top
    list.removeWhere((c) => c['name'] == car['name']);
    list.insert(0, car);
    
    // Limit to 10 stored cars
    if (list.length > 10) {
      list.removeLast();
    }
    _box.put('recentlyViewed', list);
  }
}
