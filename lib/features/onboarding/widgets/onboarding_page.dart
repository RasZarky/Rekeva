import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_text_styles.dart';

class OnboardingPage extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 40),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppTextStyles.fontFamilySyne,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyles.subheadline.copyWith(
            fontSize: 15,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
