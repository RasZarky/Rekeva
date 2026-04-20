import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  const LogoWidget({super.key, this.size = 84});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo_box',
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGlow.withValues(alpha: 0.6), 
              blurRadius: 60,
            ),
          ],
        ),
        child: Icon(CupertinoIcons.circle_grid_hex, size: size * 0.47, color: CupertinoColors.black),
      ),
    );
  }
}
