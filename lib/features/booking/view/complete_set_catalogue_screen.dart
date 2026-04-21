import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CompleteSetCatalogueScreen extends StatelessWidget {
  const CompleteSetCatalogueScreen({super.key});

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
                  children: [
                    const Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    const Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    _Badge(label: '❄️ Winter', color: AppColors.primary),
                    const SizedBox(width: 6),
                    _Badge(label: '225/65R17', color: AppColors.primary),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pre-filtered for your RAV4 · 2 tires needed',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              const Text(
                'Season and size matched automatically.',
                style: TextStyle(fontSize: 10, color: AppColors.textMuted),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _TireCard(
                      name: 'Michelin X-Ice Snow',
                      spec: '225/65R17 · Winter · 102T XL',
                      price: 219,
                      rating: 4.8,
                      isBestMatch: true,
                      onTap: () => context.push('/complete-set-breakdown'),
                    ),
                    const SizedBox(height: 10),
                    _TireCard(
                      name: 'Bridgestone Blizzak DM-V2',
                      spec: '225/65R17 · Winter · 102S',
                      price: 189,
                      rating: 4.7,
                      onTap: () => context.push('/complete-set-breakdown'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

class _TireCard extends StatelessWidget {
  final String name;
  final String spec;
  final double price;
  final double rating;
  final bool isBestMatch;
  final VoidCallback onTap;

  const _TireCard({
    required this.name,
    required this.spec,
    required this.price,
    required this.rating,
    this.isBestMatch = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isBestMatch ? AppColors.primary.withValues(alpha: 0.08) : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isBestMatch ? AppColors.primary.withValues(alpha: 0.25) : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isBestMatch)
              Positioned(
                top: -17,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  child: const Text(
                    'BEST MATCH',
                    style: TextStyle(color: CupertinoColors.black, fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isBestMatch ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🏷️', style: TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: CupertinoColors.white)),
                          const SizedBox(height: 2),
                          Text(spec, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$${price.toStringAsFixed(0)}', style: const TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 17, fontWeight: FontWeight.w800, color: CupertinoColors.white)),
                        const Text('per tire', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: const Text('✓ In stock', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text('⭐ $rating', style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ),
                      ],
                    ),
                    Text(
                      '2 × \$${price.toStringAsFixed(0)}',
                      style: const TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
