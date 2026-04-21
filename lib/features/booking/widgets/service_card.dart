import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/booking_bloc.dart';

class ServiceCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final double price;
  final String? priceSuffix;
  final String time;
  final List<String>? includes;
  final bool isPopular;
  final bool isValue;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.price,
    this.priceSuffix,
    required this.time,
    this.includes,
    this.isPopular = false,
    this.isValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final isSelected = state.service == title;
        return GestureDetector(
          onTap: () => context.read<BookingBloc>().setService(title, price),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(icon, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isPopular || isValue)
                            Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: isPopular ? const Color(0xFF14532D) : const Color(0xFF713F12),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                isPopular ? 'MOST POPULAR' : 'BEST VALUE',
                                style: TextStyle(
                                  color: isPopular ? const Color(0xFF4ADE80) : const Color(0xFFFCD34D),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: AppTextStyles.fontFamilySyne,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: CupertinoColors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            desc,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w300,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'From \$${price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              if (priceSuffix != null)
                                Text(
                                  priceSuffix!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '⏱ $time',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textMuted,
                            ),
                          ),
                          if (includes != null && includes!.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: includes!.map((item) => _InclChip(label: item)).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: _CheckIcon(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          CupertinoIcons.check_mark,
          size: 10,
          weight: 800,
          color: CupertinoColors.black,
        ),
      ),
    );
  }
}

class _InclChip extends StatelessWidget {
  final String label;
  const _InclChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
