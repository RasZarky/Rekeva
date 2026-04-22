import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ReturningCheckoutScreen extends StatelessWidget {
  const ReturningCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text('Welcome back,\nAlex.', style: AppTextStyles.headline),
              const SizedBox(height: 8),
              const Text('Your card is ready to go.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const SizedBox(height: 28),
              
              // Mini summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Seasonal Swap · RAV4', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.white)),
                        Text('\$73.45', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('ProTire Mississauga · Today · 2:00 PM', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Apple Pay primary
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/payment-processing'),
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('', style: TextStyle(color: CupertinoColors.black, fontSize: 24, height: 1)),
                      const SizedBox(width: 4),
                      const Text('Pay', style: TextStyle(fontFamily: '-apple-system', fontSize: 20, fontWeight: FontWeight.w600, color: CupertinoColors.black)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Container(height: 1, color: AppColors.border)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or pay with card', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ),
                  Expanded(child: Container(height: 1, color: AppColors.border)),
                ],
              ),
              const SizedBox(height: 16),
              
              // Saved card
              GestureDetector(
                onTap: () => context.push('/payment-processing'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: CupertinoColors.white.withValues(alpha: 0.12)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42, height: 28,
                        decoration: BoxDecoration(color: const Color(0xFF1A1FFF), borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          children: [
                            Positioned(left: 8, top: 7, child: Container(width: 14, height: 14, decoration: BoxDecoration(color: CupertinoColors.white.withValues(alpha: 0.9), shape: BoxShape.circle))),
                            Positioned(left: 16, top: 7, child: Container(width: 14, height: 14, decoration: BoxDecoration(color: const Color(0xFFFFC800).withValues(alpha: 0.8), shape: BoxShape.circle))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('•••• 4242', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CupertinoColors.white)),
                            Text('Tap to pay', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                          ],
                        ),
                      ),
                      const Icon(CupertinoIcons.right_chevron, size: 14, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
                child: const Row(
                  children: [
                    Text('🔒', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 8),
                    Expanded(child: Text('Held until the job is done.', style: TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.4))),
                  ],
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/payment-processing'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                  child: const Text('Pay \$73.45 →', textAlign: TextAlign.center, style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 17, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
