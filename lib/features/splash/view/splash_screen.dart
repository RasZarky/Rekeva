import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => context.go('/onboarding'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 24),
            const Text('Rekeva.', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: -1.5)),
            const Text('Tires. Handled.', style: AppTextStyles.subheadline),
          ],
        ),
      ),
    );
  }
}
