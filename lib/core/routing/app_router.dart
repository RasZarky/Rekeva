import 'package:go_router/go_router.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/booking/view/service_select_screen.dart';
import '../../features/booking/view/shop_list_screen.dart';
import '../../features/booking/view/checkout_screen.dart';
import '../../features/booking/view/confirmation_screen.dart';
import '../../features/booking/view/health_report_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/service-select', builder: (context, state) => const ServiceSelectScreen()),
      GoRoute(path: '/shop-list', builder: (context, state) => const ShopListScreen()),
      GoRoute(path: '/checkout', builder: (context, state) => const CheckoutScreen()),
      GoRoute(path: '/confirmation', builder: (context, state) => const ConfirmationScreen()),
      GoRoute(path: '/health', builder: (context, state) => const HealthReportScreen()),
    ],
  );
}
