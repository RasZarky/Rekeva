# Rekeva

Find a shop. Book a slot. Drive safe.

Rekeva is a high-fidelity mobile application built with Flutter, focusing on a premium iOS (Cupertino) experience. It helps users manage their vehicle's tire health, book seasonal swaps, and find trusted tire shops.

## 🚀 Architecture

The project follows a **Feature-First** (or Layered-Feature) architecture, which is highly scalable for growing teams and projects.

### Directory Structure
```text
lib/
├── core/               # Shared configurations and global components
│   ├── routing/        # Navigation logic (GoRouter)
│   ├── theme/          # Centralized design tokens (AppColors, AppTextStyles)
│   └── widgets/        # App-wide reusable Cupertino widgets
├── features/           # Independent business modules
│   ├── booking/        # Service selection, shop listing, checkout
│   ├── home/           # Vehicle dashboard and seasonal reminders
│   ├── onboarding/     # First-time user experience
│   └── splash/         # Brand introduction
└── main.dart           # App entry point and provider initialization
```

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Design System:** [Cupertino](https://api.flutter.dev/flutter/cupertino/cupertino-library.html) (iOS Fidelity)
- **State Management:** [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router)
- **Icons:** [Cupertino Icons](https://pub.dev/packages/cupertino_icons)
- **Fonts:** Syne (Headlines), DM Sans (Body), Audiowide (Brand)

## 🎨 Design Tokens

- **Primary Color:** Rekeva Green (`#22C55E`)
- **Theme:** Dark Mode optimized with system-wide adaptive support.
- **Typography:** Custom font families configured in `pubspec.yaml`.

## 📦 Getting Started

1.  **Clone the repository**
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```

## 🏗 Adding New Features

To add a new feature, create a new folder under `lib/features/` with the following sub-structure:
- `bloc/`: Business logic and state.
- `view/`: Screen implementations.
- `widgets/`: Feature-specific UI components.

Update `lib/core/routing/app_router.dart` to include the new routes.

## 🔒 Security & Privacy

- Payments are held in escrow via Stripe integration.
- No mandatory account sign-up; identity verified via phone OTP.
- Privacy-first vehicle data handling.
