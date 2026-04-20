import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class LuxuryHandoffScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  const LuxuryHandoffScreen({super.key, required this.vehicle});

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
              const SizedBox(height: 24),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF161616), Color(0xFF1C1C1C)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Text('🚗', style: TextStyle(fontSize: 52)),
                    const SizedBox(height: 12),
                    Text(
                      '${vehicle['brand']} ${vehicle['name']}',
                      style: const TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 22, fontWeight: FontWeight.w800, color: CupertinoColors.white, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Multiple configurations · 2019–present',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white.withValues(alpha: 0.04),
                        border: Border.all(color: CupertinoColors.white.withValues(alpha: 0.08)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TIRE SIZES VARY BY TRIM',
                            style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.25), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 12),
                          _LuxuryFitmentRow(label: '330i / 330e', size: '225/45R18'),
                          const SizedBox(height: 8),
                          _LuxuryFitmentRow(label: 'M340i xDrive', size: '255/35R19'),
                          const SizedBox(height: 8),
                          _LuxuryFitmentRow(label: 'M3 Competition', size: '275/35R19 F · 285/35R19 R'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Your VIN unlocks\nthe right tires.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your BMW has multiple tire configurations depending on the exact trim. Your VIN tells us exactly which one — including if front and rear are different sizes.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.6),
              ),

              const Spacer(),
              PrimaryButton(
                text: 'Enter VIN →',
                onPressed: () {
                  // TODO: Navigate to manual VIN entry
                },
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/door-jamb-scan'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: CupertinoColors.transparent,
                    border: Border.all(color: CupertinoColors.white.withValues(alpha: 0.12), width: 1.5),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('📷', style: TextStyle(fontSize: 15)),
                      SizedBox(width: 8),
                      Text(
                        'Scan door jamb instead',
                        style: TextStyle(color: Color(0x7FFFFFFF), fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Takes 2 seconds · Most accurate method',
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

class _LuxuryFitmentRow extends StatelessWidget {
  final String label;
  final String size;

  const _LuxuryFitmentRow({required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.45), fontSize: 12)),
        Text(size, style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.3), fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
