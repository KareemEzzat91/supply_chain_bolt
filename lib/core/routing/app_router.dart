import 'package:flutter/material.dart';
import 'package:supply_chain_bolt/features/main/presentation/pages/settings_page.dart';
import '../../features/main/presentation/pages/main_screen.dart';
import 'routes.dart';

// Auth Screens
import '../../features/auth/presentation/screens/manager_login_screen.dart';
import '../../features/auth/presentation/screens/manager_signup_screen.dart';
import '../../features/auth/presentation/screens/distributor_login_screen.dart';
import '../../features/auth/presentation/screens/distributor_signup_screen.dart';
import '../../features/auth/presentation/screens/start_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

// Feature Screens
import '../../features/orders/presentation/pages/order_details_screen.dart';
import '../../features/orders/presentation/pages/order_list_page.dart';
import '../../features/scan/presentation/screens/scan_screen.dart';
import '../../features/scan/presentation/screens/scan_success_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';

class AppRouter {
  static const String initial = Routes.start;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case Routes.main:
        final args = settings.arguments as Map<String, dynamic>?;
        final isManager = args?['isManager'] as bool? ?? true;
        return MaterialPageRoute(
          builder: (_) => MainScreen(isManager: isManager),
        );

      case Routes.orderDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(
            orderId: args['orderId'] as String,
          ),
        );

      case Routes.start:
        return MaterialPageRoute(builder: (_) => const StartScreen());

      case Routes.managerLoginScreen:
        return MaterialPageRoute(builder: (_) => const ManagerLoginScreen());

      case Routes.managerSignupScreen:
        return MaterialPageRoute(builder: (_) => const ManagerSignupScreen());

      case Routes.distributorLoginScreen:
        return MaterialPageRoute(
          builder: (_) => const DistributorLoginScreen(),
        );

      case Routes.distributorSignupScreen:
        return MaterialPageRoute(
          builder: (_) => const DistributorSignupScreen(),
        );

      case Routes.orderListPage:
        return MaterialPageRoute(builder: (_) => const OrderListPage());

      case Routes.scanScreen:
        return MaterialPageRoute(builder: (_) => const ScanScreen());

      case Routes.scanSuccessScreen:
        return MaterialPageRoute(builder: (_) => const ScanSuccessScreen());

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsDashboard());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
