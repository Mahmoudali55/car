import 'package:bot_toast/bot_toast.dart';
import 'package:car/core/services/services_locator.dart';
import 'package:car/core/theme/cubit/app_theme_cubit.dart';
import 'package:car/core/theme/theme_enum.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
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
    // Explicitly access context.locale to register a dependency on the localization state.
    // This ensures that the entire sub-tree rebuilds when the language is changed.
    // ignore: unused_local_variable
    final currentLocale = context.locale;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth >= 600;
        // By scaling designSize relative to the actual width/height constraints,
        // we ensure that both .w and .h get identical scaling factors on tablets (e.g. 1.35x).
        // This prevents component distortion (squares turning to rectangles) caused by different aspect ratios.
        final Size designSize = isTablet
            ? Size(constraints.maxWidth / 1.35, constraints.maxHeight / 1.35)
            : const Size(360, 690);

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => AppThemeCubit()..initial()),
                BlocProvider(create: (context) => sl<AuthCubit>()),
                BlocProvider(create: (context) => sl<HomeCubit>()),
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
                    darkTheme: appThemeData(context),
                    themeMode: context.read<AppThemeCubit>().theme == ThemeEnum.system
                        ? ThemeMode.system
                        : (context.read<AppThemeCubit>().theme == ThemeEnum.dark
                              ? ThemeMode.dark
                              : ThemeMode.light),
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
      },
    );
  }
}
