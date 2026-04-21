import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/booking_bloc.dart';
import '../widgets/service_card.dart';

class ServiceSelectScreen extends StatelessWidget {
  const ServiceSelectScreen({super.key});

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
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('🚙', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 6),
                    Text(
                      'Toyota RAV4 · 2022',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('What are we\ndoing today?', style: AppTextStyles.headline),
              const SizedBox(height: 28),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ServiceCard(
                        icon: '❄️',
                        title: 'Seasonal Swap',
                        desc: 'Swap to winters. Or back to summers.',
                        price: 49.0,
                        time: '45–60 min',
                        isPopular: true,
                        includes: ['Dismount', 'Mount', 'Balance ×4', 'TPMS reset'],
                      ),
                      const SizedBox(height: 10),
                      const ServiceCard(
                        icon: '⚙️',
                        title: 'Fit My Tires',
                        desc: 'You\'ve got tires. We\'ll fit them.',
                        price: 25.0,
                        priceSuffix: '/tire',
                        time: '60–90 min',
                      ),
                      const SizedBox(height: 10),
                      const ServiceCard(
                        icon: '🛒',
                        title: 'New Tires + Install',
                        desc: 'We\'ll help you pick the right tires and fit them same day',
                        price: 289.0,
                        time: '90–120 min',
                        isValue: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Compact upsell
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontFamily: AppTextStyles.fontFamilyDMSans),
                          children: [
                            const TextSpan(text: 'Don\'t have a full set? '),
                            TextSpan(
                              text: 'We\'ll source what you\'re missing.',
                              style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.8), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        context.read<BookingBloc>().setBookingType('complete_set');
                        context.push('/complete-set-intro');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                        child: const Text('Add a pair →', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(text: 'Find a shop →', onPressed: () => context.push('/shop-list')),
            ],
          ),
        ),
      ),
    );
  }
}
