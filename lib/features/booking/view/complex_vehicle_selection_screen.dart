import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class ComplexVehicleSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  const ComplexVehicleSelectionScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    const Text('Back', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        '${vehicle['emoji']} ${vehicle['brand']} ${vehicle['name']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Pick your\ngeneration.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                  letterSpacing: -0.5,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap the shape that matches your vehicle.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _GenerationTile(
                      years: 'Generation 1',
                      tireSize: 'Standard configuration',
                      isSelected: false,
                      onTap: () {},
                    ),
                    _GenerationTile(
                      years: 'Generation 2',
                      tireSize: 'Recommended ✓',
                      isSelected: true,
                      onTap: () {},
                    ),
                    _GenerationTile(
                      years: 'Generation 3',
                      tireSize: 'Upgraded configuration',
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Older generation? Enter year manually',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12, decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'That\'s my vehicle →',
                onPressed: () => context.push('/luxury-handoff', extra: vehicle),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Configuration matched for ${vehicle['name']}',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenerationTile extends StatelessWidget {
  final String years;
  final String tireSize;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenerationTile({
    required this.years,
    required this.tireSize,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 3)] : null,
        ),
        child: Row(
          children: [
            // Silhouette Placeholder
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withValues(alpha: 0.5) : AppColors.textMuted.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(CupertinoIcons.car_detailed, size: 20, color: CupertinoColors.black),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    years,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.primary : CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tireSize,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.6) : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(CupertinoIcons.checkmark, size: 12, color: CupertinoColors.black),
              )
            else
              const Icon(CupertinoIcons.chevron_right, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
