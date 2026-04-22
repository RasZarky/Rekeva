import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class GuestCheckoutScreen extends StatelessWidget {
  const GuestCheckoutScreen({super.key});

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
              // Slot held banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Slot held! 🎉', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700)),
                        Text('Complete payment before time runs out', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('09:32', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.primary)),
                        Container(width: 90, height: 3, decoration: BoxDecoration(color: const Color(0xFF252525), borderRadius: BorderRadius.circular(3)), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: 0.8, child: Container(decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(3))))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Payment.', style: AppTextStyles.headline),
              const Text('Held until the job is done.', style: AppTextStyles.subheadline),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Text('🔒', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 8),
                    Expanded(child: Text('Your payment is held in escrow until your appointment is complete.', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w500, height: 1.4))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Mini summary
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(children: const [
                      SizedBox(width: 22, child: Text('❄️', style: TextStyle(fontSize: 13))),
                      Expanded(child: Text('Seasonal Swap · RAV4', style: TextStyle(color: AppColors.textSecondary, fontSize: 12))),
                      Text('\$73.45', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12)),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: const [
                      SizedBox(width: 22, child: Text('📅', style: TextStyle(fontSize: 13))),
                      Expanded(child: Text('Today · 2:00 PM', style: TextStyle(color: AppColors.textSecondary, fontSize: 12))),
                      Text('ProTire Mississauga', style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w600, fontSize: 11)),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('PAYMENT CARD', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 1)),
              const SizedBox(height: 10),
              const _FakeInput(label: 'Card number', value: '•••• •••• •••• ••••', icon: true),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(child: _FakeInput(label: 'Expiry', value: 'MM / YY')),
                  SizedBox(width: 10),
                  Expanded(child: _FakeInput(label: 'CVV', value: '•••')),
                ],
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/payment-processing'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.lock_shield_fill, color: CupertinoColors.black, size: 16),
                      SizedBox(width: 8),
                      Text('Pay \$73.45 Securely', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 15, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(child: Text('🔒 Secured by Stripe · Released after job is done', style: TextStyle(fontSize: 10, color: AppColors.textMuted))),
            ],
          ),
        ),
      ),
    );
  }
}

class _FakeInput extends StatelessWidget {
  final String label;
  final String value;
  final bool icon;
  const _FakeInput({required this.label, required this.value, this.icon = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(color: AppColors.surfaceLight, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              if (icon) ...[
                const Text('💳', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
              ],
              Text(value, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
