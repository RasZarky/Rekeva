import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/logo_widget.dart';
import '../widgets/pulsating_dot.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () => context.go('/onboarding'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const LogoWidget(),
                Positioned(
                  top: 6,
                  right:6,
                  child: const PulsatingDot(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                  color: AppColors.textPrimary,
                ),
                children: [
                  const TextSpan(text: 'Rekeva'),
                  const TextSpan(
                    text: '.',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const Text('Tires. Handled.', style: AppTextStyles.subheadline),
          ],
        ),
      ),
    );
  }
}
