import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class StaggeredFitmentScreen extends StatelessWidget {
  const StaggeredFitmentScreen({super.key});

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
              // Vehicle display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF161616), Color(0xFF1C1C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Text('🚗', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 10),
                    const Text('BMW M3', style: AppTextStyles.headlineMedium),
                    const SizedBox(height: 3),
                    const Text('2022 · Competition · RWD', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    const SizedBox(height: 16),
                    // Staggered rows
                    _StaggeredRow(label: 'FRONT', size: '275/35R19'),
                    const SizedBox(height: 8),
                    _StaggeredRow(label: 'REAR', size: '285/35R19'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Staggered notice
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ℹ️', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Staggered fitment', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.white)),
                          SizedBox(height: 3),
                          Text(
                            'Front and rear are different sizes. Your shop knows what to do.',
                            style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.checkmark_seal_fill, size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 6),
                    Text('Confirmed via VIN · 1FTFW1E8NFXXXXX', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Text('Switch vehicle', style: TextStyle(fontSize: 12, color: AppColors.textMuted, decoration: TextDecoration.underline)),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => context.push('/service-select'),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                      child: const Text('That\'s my car →', textAlign: TextAlign.center, style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 15, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Tire sizes confirmed for your vehicle.', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaggeredRow extends StatelessWidget {
  final String label;
  final String size;
  const _StaggeredRow({required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.5)),
              ),
              Container(width: 1, height: 14, color: AppColors.border, margin: const EdgeInsets.symmetric(horizontal: 8)),
              Text(size, style: const TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 16, fontWeight: FontWeight.w800, color: CupertinoColors.white)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
              borderRadius: BorderRadius.circular(99),
            ),
            child: const Text('✓ Confirmed', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
