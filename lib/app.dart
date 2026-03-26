import 'package:bot_toast/bot_toast.dart';
import 'package:car/core/services/services_locator.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_cubit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_routers_import.dart';
import 'core/routes/routes_name.dart';
import 'core/theme/style.dart';

class CarApp extends StatefulWidget {
  const CarApp({super.key});

  @override
  State<CarApp> createState() => _CarAppState();
}

class _CarAppState extends State<CarApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AppThemeCubit()..initial()),
            BlocProvider(create: (context) => sl<FavoritesCubit>()),
            BlocProvider(create: (context) => CartCubit()),
            BlocProvider(create: (context) => NotificationsCubit()),
          ],
          child: BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                localizationsDelegates: [
                  ...context.localizationDelegates,
                  CountryLocalizations.delegate,
                ],
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: appThemeData(context),
                initialRoute: RoutesName.splashScreen,
                onGenerateRoute: AppRouters.onGenerateRoute,
                navigatorKey: AppRouters.navigatorKey,
                builder: BotToastInit(),
                navigatorObservers: [BotToastNavigatorObserver()],
              );
            },
          ),
        );
      },
    );
  }
}
