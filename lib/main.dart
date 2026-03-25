import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/cache/hive/hive_methods.dart';
import 'core/theme/cubit/app_theme_cubit.dart';
import 'service_initialize.dart';

//
void main() async {
  await ServiceInitialize.initialize();
  final String lang = HiveMethods.getLang();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'i18n',
      fallbackLocale: const Locale('ar'),
      startLocale: Locale(lang),
      saveLocale: true,
      child: BlocProvider(create: (context) => AppThemeCubit()..initial(), child: const CarApp()),
    ),
  );
}
