import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/rekeva_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/booking_bloc.dart';

class ShopListScreen extends StatelessWidget {
  const ShopListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Nearby Shops')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shops near you.', style: AppTextStyles.headline),
              const SizedBox(height: 8),
              const Text('📍 Mississauga, ON', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: const [
                    _ShopCard(name: 'ProTire Mississauga', rating: 4.8, distance: '2.3 km', time: 'Today 2:00 PM'),
                    SizedBox(height: 12),
                    _ShopCard(name: 'Canadian Tire Erin Mills', rating: 4.5, distance: '3.1 km', time: 'Tomorrow 10:00 AM'),
                  ],
                ),
              ),
              PrimaryButton(text: 'Book Selection →', onPressed: () => context.push('/checkout')),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  final String name;
  final double rating;
  final String distance;
  final String time;

  const _ShopCard({required this.name, required this.rating, required this.distance, required this.time});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final isSelected = state.shop == name;
        return RekevaCard(
          onTap: () => context.read<BookingBloc>().setShop(name),
          color: isSelected ? AppColors.primaryGlow : AppColors.surface,
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: 1.5),
          child: Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: isSelected ? AppColors.primary : AppColors.surfaceLight, shape: BoxShape.circle),
                child: Center(child: Text(isSelected ? '✓' : '1', style: TextStyle(color: isSelected ? CupertinoColors.black : AppColors.textSecondary, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('★ $rating · $distance', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    const SizedBox(height: 6),
                    Text('📅 $time', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
