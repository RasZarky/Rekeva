import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/booking_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _showBreakdownSheet(BuildContext context, double total) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: CupertinoColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Price breakdown',
              style: TextStyle(
                fontFamily: AppTextStyles.fontFamilySyne,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(height: 20),
            _BreakdownRow(label: 'Mount & Balance ×4', value: '\$49.00'),
            _BreakdownRow(label: 'TPMS Reset', value: '\$12.00'),
            _BreakdownRow(label: 'Ontario Tire Stewardship', value: '\$4.00'),
            _BreakdownRow(label: 'HST (13%)', value: '\$8.45'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: _Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: CupertinoColors.white)),
                Text('\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontFamily: AppTextStyles.fontFamilySyne,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Rekeva 12% platform fee is covered by the shop — not charged to you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.6),
            ),
            const SizedBox(height: 24),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  'Confirm purchase →',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTextStyles.fontFamilySyne,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookingBloc>().state;
    final double totalPrice = state.price ?? 73.45;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.left_chevron,
                            size: 14, color: AppColors.textMuted),
                        SizedBox(width: 4),
                        Text('Back',
                            style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      '${state.shop ?? 'ProTire'} · 2:00 PM',
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text('Your booking.', style: AppTextStyles.headline),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _AppointmentRow(
                      icon: '❄️',
                      title: state.service ?? 'Seasonal Swap',
                      subtitle: state.vehicle ?? 'RAV4 · 2022 XLE · 225/65R17',
                      onEdit: () {},
                    ),
                    const _Divider(),
                    _AppointmentRow(
                      icon: '📍',
                      title: state.shop ?? 'ProTire Mississauga',
                      subtitle: '1234 Erin Mills Pkwy',
                      onEdit: () {},
                    ),
                    const _Divider(),
                    _AppointmentRow(
                      icon: '📅',
                      title: 'Today · 2:00 PM',
                      subtitle: '~45 min · Slot held for you',
                      onEdit: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 3),
                        Text('\$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontFamily: AppTextStyles.fontFamilySyne,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                                letterSpacing: -0.5)),
                      ],
                    ),
                    const Text(
                      'Labour · TPMS\nOTS & HST incl.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textMuted, height: 1.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => _showBreakdownSheet(context, totalPrice),
                  child: const Text(
                    'See breakdown ›',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    Text('🔒', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Held until the job is done. Shop gets paid only when you drive away.',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/phone-number'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    'Confirm purchase →',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamilySyne,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppointmentRow extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onEdit;

  const _AppointmentRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22,
          child: Text(icon,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.white)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: const Text(
            'Edit',
            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  final String label;
  final String value;

  const _BreakdownRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.white)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1,
        color: CupertinoColors.white.withValues(alpha: 0.05),
        margin: const EdgeInsets.symmetric(vertical: 10));
  }
}
