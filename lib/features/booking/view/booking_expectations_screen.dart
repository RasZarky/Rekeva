import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class BookingExpectationsScreen extends StatelessWidget {
  const BookingExpectationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56, height: 56,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(CupertinoIcons.checkmark, color: CupertinoColors.black, size: 28),
              ),
              const SizedBox(height: 20),
              const Text(
                'You\'re booked in.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.black,
                  letterSpacing: -0.5,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 6),
              const Text('ProTire Mississauga · Today · 2:00 PM', style: TextStyle(fontSize: 13, color: Color(0xFF888888))),
              const SizedBox(height: 24),
              // What to expect
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('WHAT TO EXPECT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFAAAAAA), letterSpacing: 1)),
                    SizedBox(height: 14),
                    _ExpectationTile(number: '1', title: 'Just show up — no tires to bring', description: 'Your Michelin X-Ice Snow tires are being sourced. The shop will have them ready.'),
                    SizedBox(height: 10),
                    _ExpectationTile(number: '2', title: 'Allow 90–120 minutes', description: 'New tires take a little longer — they need to be mounted, balanced and torqued.'),
                    SizedBox(height: 10),
                    _ExpectationTile(number: '3', title: 'Your old tires are disposed of', description: 'No need to take them home. The shop handles responsible disposal at no charge.'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Price summary
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const _PriceRow(label: '4 × Michelin X-Ice Snow', value: '\$876.00'),
                    const _PriceRow(label: 'Installation + TPMS + OTS', value: '\$116.00'),
                    const _PriceRow(label: 'HST (13%)', value: '\$127.56'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(color: const Color(0xFFEEEEEE), height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total paid', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.black)),
                        Text('\$1,119.56', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 20, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.go('/home'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: CupertinoColors.black, borderRadius: BorderRadius.circular(99)),
                  child: const Text('Add to calendar →', textAlign: TextAlign.center, style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 14, fontWeight: FontWeight.w800, color: CupertinoColors.white)),
                ),
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.pop(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(99)),
                  child: const Text('View QR code', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpectationTile extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  const _ExpectationTile({required this.number, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24, height: 24,
          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(number, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: CupertinoColors.black)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.black)),
              const SizedBox(height: 2),
              Text(description, style: const TextStyle(fontSize: 11, color: Color(0xFF777777), height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF888888))),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.black)),
        ],
      ),
    );
  }
}
