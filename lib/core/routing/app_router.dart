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
import '../../features/vin/view/vin_entry_screen.dart';
import '../../features/vin/view/vin_lookup_screen.dart';
import '../../features/vin/view/staggered_fitment_screen.dart';
import '../../features/booking/view/complete_set_intro_screen.dart';
import '../../features/booking/view/wheel_selection_screen.dart';
import '../../features/booking/view/complete_set_catalogue_screen.dart';
import '../../features/booking/view/complete_set_breakdown_screen.dart';
import '../../features/booking/view/shop_profile_screen.dart';
import '../../features/booking/view/time_selection_screen.dart';
import '../../features/booking/view/phone_number_screen.dart';
import '../../features/booking/view/otp_verification_screen.dart';
import '../../features/booking/view/guest_checkout_screen.dart';
import '../../features/booking/view/returning_checkout_screen.dart';
import '../../features/booking/view/payment_processing_screen.dart';
import '../../features/booking/view/payment_failed_screen.dart';
import '../../features/booking/view/booking_expectations_screen.dart';

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
      GoRoute(path: '/vin-entry', builder: (context, state) => const VinEntryScreen()),
      GoRoute(path: '/vin-lookup', builder: (context, state) => const VinLookupScreen()),
      GoRoute(path: '/staggered-fitment', builder: (context, state) => const StaggeredFitmentScreen()),
      GoRoute(path: '/complete-set-intro', builder: (context, state) => const CompleteSetIntroScreen()),
      GoRoute(path: '/wheel-selection', builder: (context, state) => const WheelSelectionScreen()),
      GoRoute(path: '/complete-set-catalogue', builder: (context, state) => const CompleteSetCatalogueScreen()),
      GoRoute(path: '/complete-set-breakdown', builder: (context, state) => const CompleteSetBreakdownScreen()),
      GoRoute(path: '/phone-number', builder: (context, state) => const PhoneNumberScreen()),
      GoRoute(path: '/otp-verification', builder: (context, state) => const OtpVerificationScreen()),
      GoRoute(path: '/guest-checkout', builder: (context, state) => const GuestCheckoutScreen()),
      GoRoute(path: '/returning-checkout', builder: (context, state) => const ReturningCheckoutScreen()),
      GoRoute(path: '/payment-processing', builder: (context, state) => const PaymentProcessingScreen()),
      GoRoute(path: '/payment-failed', builder: (context, state) => const PaymentFailedScreen()),
      GoRoute(path: '/booking-expectations', builder: (context, state) => const BookingExpectationsScreen()),
      GoRoute(
        path: '/shop-profile',
        builder: (context, state) => ShopProfileScreen(
          shopName: state.extra as String? ?? 'ProTire Mississauga',
        ),
      ),
      GoRoute(
        path: '/time-selection',
        builder: (context, state) => TimeSelectionScreen(
          shopName: state.extra as String? ?? 'ProTire Mississauga',
        ),
      ),
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
