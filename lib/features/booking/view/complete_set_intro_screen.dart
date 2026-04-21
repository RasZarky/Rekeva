import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/booking_bloc.dart';

class CompleteSetIntroScreen extends StatelessWidget {
  const CompleteSetIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _ContextPill(label: '❄️ Seasonal Swap', color: AppColors.primary),
                  _ContextPill(label: '🚙 RAV4 · 225/65R17', color: AppColors.primary),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Let\'s complete\nyour set first.',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 10),
              const Text(
                'Tell us which wheels need tires. We\'ll handle the rest in one visit.',
                style: AppTextStyles.subheadline,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ONE APPOINTMENT · EVERYTHING DONE',
                      style: AppTextStyles.caption.copyWith(fontSize: 11, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 14),
                    const _FeatureRow(icon: '🏷️', text: 'New winter tires fitted on missing wheels'),
                    const SizedBox(height: 10),
                    const _FeatureRow(icon: '❄️', text: 'Seasonal swap on remaining wheels'),
                    const SizedBox(height: 10),
                    const _FeatureRow(icon: '⚙️', text: 'Balance, torque, TPMS — all 4 done'),
                    const SizedBox(height: 10),
                    const _FeatureRow(icon: '💳', text: 'One price · one visit · one booking'),
                  ],
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<BookingBloc>().setBookingType('complete_set');
                  context.push('/wheel-selection');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    'Let\'s go →',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamilySyne,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Next — which wheels need new tires',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContextPill extends StatelessWidget {
  final String label;
  final Color color;

  const _ContextPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String icon;
  final String text;

  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(icon, style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
