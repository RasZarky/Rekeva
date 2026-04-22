import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Simulate payment processing delay
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Randomly fail for demo purposes (30% chance of failure)
        final bool isSuccess = Random().nextDouble() > 0.3;
        if (isSuccess) {
          context.pushReplacement('/confirmation');
        } else {
          context.pushReplacement('/payment-failed');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.15), width: 3),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0, left: 0, right: 0,
                      child: Container(
                        height: 36,
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: AppColors.primary, width: 3)),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Confirming your\nappointment…',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTextStyles.fontFamilySyne,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: CupertinoColors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Securing your slot at\nProTire Mississauga',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w300,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
