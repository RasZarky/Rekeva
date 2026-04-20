import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import 'silhouette_painter.dart';

class GenerationTile extends StatelessWidget {
  final String years;
  final String tireSize;
  final bool isSelected;
  final VoidCallback onTap;

  const GenerationTile({
    super.key,
    required this.years,
    required this.tireSize,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : const Color(0xFF1A1A1A),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ] : null,
        ),
        child: Row(
          children: [
            // Silhouette Visualization
            SizedBox(
              width: 100,
              height: 30,
              child: CustomPaint(
                painter: SilhouettePainter(
                  color: isSelected ? AppColors.primary : CupertinoColors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    years,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.primary : CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tireSize,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.6) : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(CupertinoIcons.checkmark, size: 12, color: CupertinoColors.black),
              )
            else
              const Icon(CupertinoIcons.chevron_right, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
