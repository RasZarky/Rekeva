import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';

class SeasonalBanner extends StatelessWidget {
  const SeasonalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Text('❄️', style: TextStyle(fontSize: 30)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Winter tire season is here',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 14),
                Text(
                  'Book before slots fill up in your area',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Icon(CupertinoIcons.right_chevron, size: 14, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
