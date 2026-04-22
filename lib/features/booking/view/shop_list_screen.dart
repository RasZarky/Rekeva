import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/booking_bloc.dart';

class ShopListScreen extends StatelessWidget {
  const ShopListScreen({super.key});

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
              const Text('Shops near you.', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Text('📍', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 4),
                  Text('Mississauga, ON', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
                  SizedBox(width: 6),
                  Text('Change', style: TextStyle(fontSize: 12, color: AppColors.primary, decoration: TextDecoration.underline)),
                ],
              ),
              const SizedBox(height: 24),
              // Map/List toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: const Text('🗺 Map', textAlign: TextAlign.center, style: TextStyle(color: CupertinoColors.black, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text('☰ List', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Map Mock
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // Grid background to simulate map
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.05,
                          child: _MapGrid(),
                        ),
                      ),
                      // User dot
                      const Center(
                        child: Icon(CupertinoIcons.circle_fill, color: CupertinoColors.systemBlue, size: 12),
                      ),
                      // Pins
                      const Positioned(
                        top: 40, left: 60,
                        child: _MapPin(number: '1', isActive: true),
                      ),
                      const Positioned(
                        top: 20, right: 80,
                        child: _MapPin(number: '2', isActive: false),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: const [
                    _ShopCard(number: 1, name: 'ProTire Mississauga', rating: 4.8, distance: '2.3 km', time: 'Today 2:00 PM', isPriority: true),
                    SizedBox(height: 10),
                    _ShopCard(number: 2, name: 'Canadian Tire Erin Mills', rating: 4.5, distance: '3.1 km', time: 'Tomorrow 10:00 AM'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(text: 'Book this shop →', onPressed: () => context.push('/shop-profile')),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (i) => Expanded(
        child: Row(
          children: List.generate(10, (j) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
            ),
          )),
        ),
      )),
    );
  }
}

class _MapPin extends StatelessWidget {
  final String number;
  final bool isActive;
  const _MapPin({required this.number, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.textMuted,
        shape: BoxShape.circle,
        boxShadow: isActive ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 12)] : null,
      ),
      child: Center(child: Text(number, style: const TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.w800, fontSize: 12))),
    );
  }
}

class _ShopCard extends StatelessWidget {
  final int number;
  final String name;
  final double rating;
  final String distance;
  final String time;
  final bool isPriority;

  const _ShopCard({
    required this.number, 
    required this.name, 
    required this.rating, 
    required this.distance, 
    required this.time,
    this.isPriority = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final isSelected = state.shop == name;
        return GestureDetector(
          onTap: () {
            context.read<BookingBloc>().setShop(name);
            context.push('/shop-profile', extra: name);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text('$number', style: TextStyle(color: isSelected ? CupertinoColors.black : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 12))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: CupertinoColors.white))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                            ),
                            child: const Text('Open', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('★', style: TextStyle(color: AppColors.warning, fontSize: 11)),
                          const SizedBox(width: 2),
                          Text('$rating · (127) · $distance', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('📅 $time', style: TextStyle(fontSize: 11, color: isSelected ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.w500)),
                          if (isPriority) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(99),
                                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                              ),
                              child: const Text('PRIORITY', style: TextStyle(color: AppColors.primary, fontSize: 9, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
