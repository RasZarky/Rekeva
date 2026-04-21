import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PinkSlipSourceScreen extends StatelessWidget {
  const PinkSlipSourceScreen({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null && context.mounted) {
        // In a real app, we would process the image here
        // For now, we just navigate to the confirmation screen
        context.push('/pink-slip-confirm');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

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
                  children: const [
                    Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text('Pink slip.', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              const Text(
                'We\'ll read your vehicle details from it. Takes two seconds.',
                style: AppTextStyles.subheadline,
              ),
              const SizedBox(height: 28),
              // Choose from photos
              _SourceCard(
                icon: '🖼️',
                title: 'Choose from photos',
                description: 'Select a photo or screenshot of your\npink slip from your camera roll',
                isPrimary: true,
                onTap: () => _pickImage(context, ImageSource.gallery),
              ),
              const SizedBox(height: 12),
              // Take photo
              _SourceCard(
                icon: '📷',
                title: 'Take a photo now',
                description: 'Point your camera at your physical\npink slip document',
                isPrimary: false,
                onTap: () => _pickImage(context, ImageSource.camera),
              ),
              const SizedBox(height: 20),
              // Help section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WHERE TO FIND YOUR PINK SLIP',
                      style: AppTextStyles.caption.copyWith(fontSize: 10, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 10),
                    const _HelpItem(icon: '📱', text: 'Your pink slip app — screenshot it'),
                    const SizedBox(height: 8),
                    const _HelpItem(icon: '📧', text: 'Your email from your insurer'),
                    const SizedBox(height: 8),
                    const _HelpItem(icon: '🚗', text: 'Glove box — photograph it'),
                  ],
                ),
              ),
              const Spacer(),
              // Privacy note
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(CupertinoIcons.shield_fill, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'We read your vehicle details and immediately discard the image. Your pink slip information is never stored.',
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final bool isPrimary;
  final VoidCallback onTap;

  const _SourceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary.withValues(alpha: 0.08) : AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isPrimary ? AppColors.primary.withValues(alpha: 0.2) : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                width: isPrimary ? 60 : 52,
                height: isPrimary ? 60 : 52,
                decoration: BoxDecoration(
                  color: isPrimary ? AppColors.primary : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(isPrimary ? 16 : 14),
                ),
                alignment: Alignment.center,
                child: Text(icon, style: TextStyle(fontSize: isPrimary ? 28 : 24)),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: isPrimary ? 17 : 15,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isPrimary ? AppColors.textSecondary : AppColors.textMuted,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpItem extends StatelessWidget {
  final String icon;
  final String text;

  const _HelpItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20, child: Text(icon, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center)),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}
