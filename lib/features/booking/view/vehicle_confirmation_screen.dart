import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/booking_bloc.dart';

class VehicleConfirmationScreen extends StatelessWidget {
  const VehicleConfirmationScreen({super.key});

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
                  children: [
                    const Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    const Text('Back', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // VIN source badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: const Row(
                      children: [
                        Text('📷', style: TextStyle(fontSize: 11)),
                        SizedBox(width: 5),
                        Text('VIN scanned', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Door jamb sticker', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 20),

              // Vehicle Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
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
                    const Text('🚙', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 12),
                    const Text(
                      'Toyota RAV4',
                      style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 24, fontWeight: FontWeight.w800, color: CupertinoColors.white, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '2022 · XLE · FWD',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 24),

                    // Tire size badge
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
                              Text(
                                'TIRE SIZE CONFIRMED',
                                style: TextStyle(color: AppColors.primary.withValues(alpha: 0.7), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                              ),
                              const Text(
                                '225/65R17',
                                style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary),
                              ),
                            ],
                          ),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            child: const Center(child: Text('✓', style: TextStyle(fontWeight: FontWeight.w800, color: CupertinoColors.black))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // VIN confirmed note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.checkmark_circle, size: 12, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  const Text('2T3BFREV9NW123456', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Text(
                    'Not your vehicle? Scan again',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12, decoration: TextDecoration.underline),
                  ),
                ),
              ),

              const Spacer(),
              PrimaryButton(
                text: 'That\'s my car →',
                onPressed: () {
                  context.read<BookingBloc>().setVehicle('Toyota RAV4');
                  context.push('/service-select');
                },
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Tire size confirmed. No account needed.',
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
