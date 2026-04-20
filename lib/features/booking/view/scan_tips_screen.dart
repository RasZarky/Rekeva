import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class ScanTipsScreen extends StatelessWidget {
  const ScanTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    const Text('Back', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Let\'s try\nanother way.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                  letterSpacing: -0.5,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A few things to check.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 28),
              
              Expanded(
                child: ListView(
                  children: const [
                    _TipItem(
                      icon: '💡',
                      title: 'Turn on your torch',
                      description: 'The sticker is inside your door frame. It\'s dark. Use the torch button.',
                    ),
                    _TipItem(
                      icon: '🚪',
                      title: 'Open your driver\'s door fully',
                      description: 'The sticker is on the door jamb — the metal frame, not the door itself.',
                    ),
                    _TipItem(
                      icon: '🧹',
                      title: 'Clean the sticker',
                      description: 'Dust or grime can block the camera. Wipe it with your sleeve.',
                    ),
                    _TipItem(
                      icon: '📏',
                      title: 'Hold steady, 15–20cm away',
                      description: 'Not too close, not too far. Fill the frame with the sticker.',
                    ),
                  ],
                ),
              ),

              PrimaryButton(
                text: 'Try again →',
                onPressed: () => context.pop(),
              ),
              const SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: Implement manual VIN entry
                  },
                  child: const Text(
                    'Enter VIN manually instead',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12, decoration: TextDecoration.underline),
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

class _TipItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const _TipItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: CupertinoColors.white, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
