import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        // Simple logic for "at least some characters" to enable button
        _canContinue = _controller.text.length >= 7;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'What\'s your\nnumber?',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 8),
              const Text(
                'So we can send your confirmation.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _canContinue ? AppColors.primary : AppColors.border,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    const Text('🇨🇦', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 12),
                    const Text(
                      '+1',
                      style: TextStyle(
                        fontSize: 17,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CupertinoTextField(
                        controller: _controller,
                        keyboardType: TextInputType.phone,
                        placeholder: '(647) 555-0123',
                        placeholderStyle: const TextStyle(color: AppColors.textMuted, fontSize: 17),
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 17,
                          letterSpacing: 0.5,
                        ),
                        decoration: null,
                        cursorColor: AppColors.primary,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'No account needed. We\'ll text you a code.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _canContinue ? () => context.push('/otp-verification') : null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _canContinue ? AppColors.primary : AppColors.primary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    'Send me a code →',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamilySyne,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: _canContinue ? CupertinoColors.black : CupertinoColors.black.withValues(alpha: 0.5),
                    ),
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
