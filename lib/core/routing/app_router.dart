import 'package:go_router/go_router.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/booking/view/service_select_screen.dart';
import '../../features/booking/view/shop_list_screen.dart';
import '../../features/booking/view/checkout_screen.dart';
import '../../features/booking/view/confirmation_screen.dart';
import '../../features/vehicle/view/health_report_screen.dart';
import '../../features/scan/view/door_jamb_scan_screen.dart';
import '../../features/vehicle/view/vehicle_confirmation_screen.dart';
import '../../features/scan/view/scan_failed_screen.dart';
import '../../features/scan/view/scan_tips_screen.dart';
import '../../features/search/view/vehicle_search_screen.dart';
import '../../features/search/view/complex_vehicle_selection_screen.dart';
import '../../features/search/view/luxury_handoff_screen.dart';
import '../../features/booking/view/returning_summary_screen.dart';
import '../../features/pink_slip/view/pink_slip_source_screen.dart';
import '../../features/pink_slip/view/pink_slip_confirm_screen.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
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
      GoRoute(path: '/door-jamb-scan', builder: (context, state) => const DoorJambScanScreen()),
      GoRoute(path: '/vehicle-confirmation', builder: (context, state) => const VehicleConfirmationScreen()),
      GoRoute(path: '/scan-failed', builder: (context, state) => const ScanFailedScreen()),
      GoRoute(path: '/scan-tips', builder: (context, state) => const ScanTipsScreen()),
      GoRoute(path: '/vehicle-search', builder: (context, state) => const VehicleSearchScreen()),
      GoRoute(path: '/returning-summary', builder: (context, state) => const ReturningSummaryScreen()),
      GoRoute(path: '/pink-slip-source', builder: (context, state) => const PinkSlipSourceScreen()),
      GoRoute(path: '/pink-slip-confirm', builder: (context, state) => const PinkSlipConfirmScreen()),
      GoRoute(
        path: '/complex-vehicle-selection',
        builder: (context, state) => ComplexVehicleSelectionScreen(
          vehicle: state.extra as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        path: '/luxury-handoff',
        builder: (context, state) => LuxuryHandoffScreen(
          vehicle: state.extra as Map<String, dynamic>,
        ),
      ),
    ],
  );
}
