part of 'app_routers_import.dart';

class AppRouters {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) args = settings.arguments;
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.mainLayout:
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case RoutesName.allBrandsScreen:
        return MaterialPageRoute(builder: (_) => const AllBrandsScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeGuestScreen());
      case RoutesName.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(create: (context) => sl<AuthCubit>(), child: LoginScreen()),
        );
      case RoutesName.registerScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (context) => sl<AuthCubit>(), child: const RegisterScreen()),
        );
      case RoutesName.carDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => CarDetailsScreen(car: args as Map<String, dynamic>),
        );
      case RoutesName.popularCarsScreen:
        return MaterialPageRoute(builder: (_) => const PopularCarsScreen());
      case RoutesName.filterScreen:
        return MaterialPageRoute(builder: (_) => const FilterScreen());

      default:
        return null;
    }
  }
}
