import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';

class SeasonalBanner extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const SeasonalBanner({
    super.key,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.12) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
            width: isActive ? 1.5 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    spreadRadius: 3,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surfaceLight,
                border: Border.all(
                  color: isActive ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text('❄️', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Winter tire season is here',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isActive ? 'Tap to book Seasonal Swap →' : 'Book before slots fill up in your area',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.right_chevron,
              size: 18,
              color: isActive ? AppColors.primary : AppColors.textMuted,
              weight: isActive ? 700 : 400,
            ),
          ],
        ),
      ),
    );
  }
}
