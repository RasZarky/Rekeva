import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class ReturningSummaryScreen extends StatelessWidget {
  const ReturningSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Seasonal source badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      children: const [
                        Text('❄️', style: TextStyle(fontSize: 11)),
                        SizedBox(width: 5),
                        Text(
                          'Seasonal reminder',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Everything pre-filled',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Here\'s what\nyou booked last time.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                  letterSpacing: -0.5,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 18),
              
              // Pre-filled summary card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const _SummaryRow(
                      icon: '🚙',
                      label: 'Vehicle',
                      value: 'RAV4 · 225/65R17',
                    ),
                    const SizedBox(height: 10),
                    const _SummaryRow(
                      icon: '❄️',
                      label: 'Service',
                      value: 'Seasonal Swap',
                      valueColor: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    const _SummaryRow(
                      icon: '📍',
                      label: 'Last shop',
                      value: 'ProTire Mississauga',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppColors.border, height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Est. total',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                        ),
                        Text(
                          '\$73.45',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamilySyne,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Pre-filled from your last booking · Change anything below',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ),
              const SizedBox(height: 24),
              
              // Change chips
              Wrap(
                spacing: 8,
                children: const [
                  _ChangeChip(label: 'Change vehicle'),
                  _ChangeChip(label: 'Change shop'),
                ],
              ),
              
              const Spacer(),
              PrimaryButton(
                text: 'Pick a time →',
                onPressed: () {
                  context.push('/shop-list');
                },
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Skips straight to slot picker.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(icon, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? CupertinoColors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ChangeChip extends StatelessWidget {
  final String label;
  const _ChangeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class Divider extends StatelessWidget {
  final Color color;
  final double height;
  const Divider({super.key, required this.color, this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Container(height: height, color: color);
  }
}
