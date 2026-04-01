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
      case RoutesName.brandCarsScreen:
        final brandArgs = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BrandCarsScreen(
            brandNameEn: brandArgs['nameEn'] as String,
            brandNameAr: brandArgs['nameAr'] as String,
            brandImage: brandArgs['image'] as String,
          ),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeGuestScreen());
      case RoutesName.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: LoginScreen(),
          ),
        );
      case RoutesName.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case RoutesName.carDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => CarDetailsScreen(car: args as Map<String, dynamic>),
        );
      case RoutesName.bankOffersScreen:
        return MaterialPageRoute(
          builder: (_) => BankOffersScreen(car: args as Map<String, dynamic>),
        );
      case RoutesName.carReservationScreen:
        final argsMap = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CarReservationScreen(
            car: argsMap['car'],
            isFromLink: argsMap['isFromLink'] ?? false,
          ),
        );
      case RoutesName.popularCarsScreen:
        return MaterialPageRoute(builder: (_) => const PopularCarsScreen());
      case RoutesName.filterScreen:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      case RoutesName.cartScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: ctx.read<CartCubit>(),
            child: const CartScreen(),
          ),
        );
      case RoutesName.paymentScreen:
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(totalPrice: args as double),
        );
      case RoutesName.paymentSuccessScreen:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());
      case RoutesName.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case RoutesName.faqScreen:
        return MaterialPageRoute(builder: (_) => const FAQScreen());
      case RoutesName.trackOrderScreen:
        return MaterialPageRoute(builder: (_) => const TrackOrderScreen());
      case RoutesName.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const SettingsScreen(),
          ),
        );
      case RoutesName.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const UserProfileScreen(),
          ),
        );
      case RoutesName.tradeInScreen:
        return MaterialPageRoute(builder: (_) => const TradeInScreen());
      case RoutesName.requestCarScreen:
        return MaterialPageRoute(builder: (_) => const RequestCarScreen());
      case RoutesName.importOnDemandScreen:
        return MaterialPageRoute(builder: (_) => const ImportOnDemandScreen());
      case RoutesName.financingScreen:
        return MaterialPageRoute(
          builder: (_) => FinancingScreen(car: args as Map<String, dynamic>?),
        );
      case RoutesName.carDetailingScreen:
        return MaterialPageRoute(builder: (_) => const CarDetailingScreen());
      case RoutesName.shippingScreen:
        return MaterialPageRoute(builder: (_) => const ShippingScreen());
      case RoutesName.bespokeSelectionScreen:
        return MaterialPageRoute(
          builder: (_) => const BespokeSelectionScreen(),
        );
      case RoutesName.carValuationScreen:
        return MaterialPageRoute(builder: (_) => const CarValuationScreen());
      case RoutesName.sellCarScreen:
        return MaterialPageRoute(builder: (_) => const SellCarScreen());
      case RoutesName.bookingAppointmentScreen:
        return MaterialPageRoute(
          builder: (_) => const BookingAppointmentScreen(),
        );
      case RoutesName.serviceHistoryScreen:
        return MaterialPageRoute(builder: (_) => const ServiceHistoryScreen());
      case RoutesName.supportScreen:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      case RoutesName.aboutScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());

      case RoutesName.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminMainLayout());

      // Admin Management Routes
      case RoutesName.manageCars:
        return MaterialPageRoute(builder: (_) => const ManageCarsScreen());
      case RoutesName.manageBookings:
        return MaterialPageRoute(builder: (_) => const ManageBookingsScreen());
      case RoutesName.manageUsers:
        return MaterialPageRoute(builder: (_) => const ManageUsersScreen());
      case RoutesName.revenueReport:
      case RoutesName.revenueReports:
        return MaterialPageRoute(builder: (_) => const RevenueReportScreen());
      case RoutesName.addCar:
        return MaterialPageRoute(builder: (_) => const AddCarScreen());
      case RoutesName.manageServices:
        return MaterialPageRoute(builder: (_) => const ManageServicesScreen());
      case RoutesName.inspectionReports:
        return MaterialPageRoute(
          builder: (_) => const InspectionReportsScreen(),
        );
      case RoutesName.adminSettings:
        return MaterialPageRoute(builder: (_) => const AdminSettingsScreen());
      case RoutesName.allActivities:
        return MaterialPageRoute(builder: (_) => const AllActivitiesScreen());
      case RoutesName.adminNotifications:
        return MaterialPageRoute(
          builder: (_) => const AdminNotificationsScreen(),
        );
      case RoutesName.securitySettings:
        return MaterialPageRoute(builder: (_) => const AdminSecurityScreen());
      case RoutesName.systemAlerts:
        return MaterialPageRoute(builder: (_) => const SystemAlertsScreen());
      case RoutesName.manageCategories:
        return MaterialPageRoute(builder: (_) => const ManageCategoriesScreen());
      case RoutesName.discountCoupons:
        return MaterialPageRoute(builder: (_) => const DiscountCouponsScreen());
      case RoutesName.termsSettings:
        return MaterialPageRoute(builder: (_) => const TermsSettingsScreen());
      case RoutesName.adminSupport:
        return MaterialPageRoute(builder: (_) => const AdminSupportScreen());
      case RoutesName.contactDeveloper:
        return MaterialPageRoute(builder: (_) => const ContactDeveloperScreen());

      default:
        return null;
    }
  }
}
