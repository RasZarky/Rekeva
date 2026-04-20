import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
                      child: const Icon(CupertinoIcons.checkmark_seal_fill, size: 40, color: CupertinoColors.black),
                    ),
                    const SizedBox(height: 48),
                    const Text('Tires.\nDone.', textAlign: TextAlign.center, style: TextStyle(fontSize: 52, fontWeight: FontWeight.w900, height: 1.0)),
                    const SizedBox(height: 20),
                    const Text('Find a shop. Book a slot.\nDrive safe.', textAlign: TextAlign.center, style: AppTextStyles.subheadline),
                  ],
                ),
              ),
              PrimaryButton(text: 'Next →', onPressed: () => context.go('/home')),
              CupertinoButton(
                child: const Text('Skip', style: TextStyle(color: AppColors.textMuted, decoration: TextDecoration.underline)),
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
