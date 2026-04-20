import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/rekeva_card.dart';

class HomeActionTile extends StatelessWidget {
  final String icon;
  final String label;
  const HomeActionTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return RekevaCard(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
