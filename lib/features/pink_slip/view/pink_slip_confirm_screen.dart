import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PinkSlipConfirmScreen extends StatelessWidget {
  const PinkSlipConfirmScreen({super.key});

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
              // Source badge
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
                        Text('📄', style: TextStyle(fontSize: 12)),
                        SizedBox(width: 5),
                        Text('Pink slip read', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Ontario · Intact Insurance', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
              const SizedBox(height: 20),
              // Vehicle Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
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
                    const Text('🚙', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 10),
                    const Text('Toyota RAV4', style: AppTextStyles.headlineMedium),
                    const SizedBox(height: 3),
                    const Text('2022 · XLE · FWD', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    const SizedBox(height: 16),
                    // Tire size box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('TIRE SIZE CONFIRMED', style: AppTextStyles.caption.copyWith(fontSize: 10, color: AppColors.primary.withValues(alpha: 0.7))),
                              const SizedBox(height: 2),
                              const Text('225/65R17', style: AppTextStyles.headlineMedium),
                            ],
                          ),
                          Container(
                            width: 28, height: 28,
                            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            child: const Icon(CupertinoIcons.check_mark, size: 14, color: CupertinoColors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Extracted Info Table
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EXTRACTED FROM YOUR PINK SLIP', style: AppTextStyles.caption.copyWith(fontSize: 10, color: AppColors.textMuted)),
                    const SizedBox(height: 12),
                    const _InfoRow(label: 'Year', value: '2022'),
                    const SizedBox(height: 8),
                    const _InfoRow(label: 'Make', value: 'Toyota'),
                    const SizedBox(height: 8),
                    const _InfoRow(label: 'Model', value: 'RAV4 XLE'),
                    const SizedBox(height: 8),
                    Container(height: 1, color: AppColors.border),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Image discarded', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        Text('✓ Not stored', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.shield_fill, size: 12, color: AppColors.textMuted),
                    SizedBox(width: 6),
                    Text('Insurance image read and discarded', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Text('Not your vehicle? Try again', style: TextStyle(fontSize: 12, color: AppColors.textMuted, decoration: TextDecoration.underline)),
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
                  const Text('Tire size confirmed. No account needed.', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 12, color: CupertinoColors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
