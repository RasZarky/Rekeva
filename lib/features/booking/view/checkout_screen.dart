import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/rekeva_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../bloc/booking_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookingBloc>().state;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Review Booking')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your booking.', style: AppTextStyles.headline),
              const SizedBox(height: 28),
              
              RekevaCard(
                child: Column(
                  children: [
                    _CheckoutRow(icon: '🚙', label: 'Vehicle', value: state.vehicle ?? 'RAV4'),
                    const _Divider(),
                    _CheckoutRow(icon: '❄️', label: 'Service', value: state.service ?? 'Seasonal Swap'),
                    const _Divider(),
                    _CheckoutRow(icon: '📍', label: 'Shop', value: state.shop ?? 'ProTire'),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.primaryGlow, borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    Text('\$${state.price?.toStringAsFixed(2) ?? '73.45'}', 
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.primary)
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              Row(
                children: [
                  const Icon(CupertinoIcons.lock_shield_fill, size: 20, color: AppColors.textMuted),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Payment held in escrow until job is complete. Shop is paid only when you drive away.', style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.4))),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(text: 'Confirm & Pay →', onPressed: () => context.push('/confirmation')),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const _CheckoutRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.border, margin: const EdgeInsets.symmetric(vertical: 12));
  }
}
