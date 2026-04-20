import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/rekeva_card.dart';
import '../bloc/booking_bloc.dart';

class ServiceCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final double price;
  final bool isPopular;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.price,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final isSelected = state.service == title;
        return RekevaCard(
          onTap: () => context.read<BookingBloc>().setService(title, price),
          color: isSelected ? AppColors.primaryGlow : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isPopular)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF14532D),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: const Text(
                          'MOST POPULAR',
                          style: TextStyle(
                            color: Color(0xFF4ADE80),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                    const SizedBox(height: 12),
                    Text('From \$${price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  ],
                ),
              ),
              if (isSelected) const Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.primary, size: 22),
            ],
          ),
        );
      },
    );
  }
}
