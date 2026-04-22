import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

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
              const SizedBox(height: 20),
              // Error state
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                  border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.25)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.xmark, color: Color(0xFFEF4444), size: 24),
                    ),
                    const SizedBox(height: 14),
                    const Text('Card didn\'t work.', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 20, fontWeight: FontWeight.w800, color: CupertinoColors.white)),
                    const SizedBox(height: 6),
                    const Text(
                      'Your card was declined. Your appointment slot is still held for 5 minutes.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Retry options
              const Text('TRY A DIFFERENT CARD', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1)),
              const SizedBox(height: 12),
              _RetryOptionTile(icon: '💳', title: 'Add new card', onTap: () => context.pop()),
              const SizedBox(height: 8),
              _RetryOptionTile(icon: '📱', title: 'Pay with Apple Pay', onTap: () => context.pop()),
              
              const SizedBox(height: 24),
              // Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('⏱', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Slot held for ',
                      style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                      children: [
                        TextSpan(text: '4:32', style: TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: CupertinoButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel and go back', style: TextStyle(fontSize: 12, color: AppColors.textMuted, decoration: TextDecoration.underline)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RetryOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const _RetryOptionTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.borderMid),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary))),
            const Icon(CupertinoIcons.right_chevron, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
