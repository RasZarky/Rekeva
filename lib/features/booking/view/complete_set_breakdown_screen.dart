import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CompleteSetBreakdownScreen extends StatelessWidget {
  const CompleteSetBreakdownScreen({super.key});

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
              const SizedBox(height: 24),
              const Text(
                'Here\'s your\nfull booking.',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 6),
              const Text(
                'One visit · everything done.',
                style: TextStyle(fontSize: 13, color: AppColors.textMuted),
              ),
              const SizedBox(height: 20),
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
                    const _SectionHeader(label: 'NEW WINTER TIRES · FL + FR', color: AppColors.primary),
                    const SizedBox(height: 10),
                    const _PriceRow(label: '2 × Michelin X-Ice Snow', value: '\$438.00'),
                    const _PriceRow(label: 'Mount & Balance (×2)', value: '\$50.00'),
                    const _PriceRow(label: 'TPMS Reset (×2)', value: '\$6.00'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: _CustomDivider()),
                    const _SectionHeader(label: 'SEASONAL SWAP · RL + RR', color: AppColors.textSecondary),
                    const SizedBox(height: 10),
                    const _PriceRow(label: 'Dismount & Mount (×2)', value: '\$34.50'),
                    const _PriceRow(label: 'Balance (×2)', value: '\$24.50'),
                    const _PriceRow(label: 'TPMS Reset (×2)', value: '\$6.00'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: _CustomDivider()),
                    const _PriceRow(label: 'Ontario Tire Stewardship', value: '\$4.00'),
                    const _PriceRow(label: 'HST (13%)', value: '\$72.59'),
                    const SizedBox(height: 8),
                    const _CustomDivider(height: 1, color: AppColors.border),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: CupertinoColors.white)),
                        Text('\$635.59', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('⏱', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Allow 90–120 min. You\'ll leave with a matched full set of winter tires.',
                        style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/shop-list'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                  child: const Text('Find me a shop →', textAlign: TextAlign.center, style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 15, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text('Next — shops with Michelin X-Ice in stock', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final Color color;
  const _SectionHeader({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 1));
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          Text(value, style: const TextStyle(fontSize: 12, color: CupertinoColors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  final double height;
  final Color? color;
  const _CustomDivider({this.height = 0.5, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(height: height, color: color ?? CupertinoColors.white.withValues(alpha: 0.06));
  }
}
