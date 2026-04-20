import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/primary_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4).withValues(alpha: 0.1), 
                  shape: BoxShape.circle, 
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                child: const Icon(CupertinoIcons.checkmark, color: AppColors.primary, size: 36),
              ),
              const SizedBox(height: 24),
              const Text('You\'re booked in.', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
              const Text('Show this QR code at the shop.', style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w300)),
              
              const SizedBox(height: 48),
              
              // Animated QR Container
              TweenAnimationBuilder(
                duration: const Duration(seconds: 1),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [BoxShadow(color: AppColors.primaryGlow.withValues(alpha: 0.12), blurRadius: 40, spreadRadius: 5)],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 180, height: 180, 
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ), // QR Mock
                      const SizedBox(height: 20),
                      const Text('RKV-4821-X92', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              
              const Spacer(),
              PrimaryButton(text: 'Done', onPressed: () => context.go('/home')),
              const SizedBox(height: 8),
              const Text('Confirmation sent via SMS', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
