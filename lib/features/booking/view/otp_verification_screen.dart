import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isVerifying = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    
    // Check if all fields are filled
    bool allFilled = _controllers.every((c) => c.text.isNotEmpty);
    if (allFilled) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    setState(() => _isVerifying = true);
    // Simulate verification delay
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // Logic: If the 4th digit is '1', treat as guest. If '2', treat as returning.
      // This is a simple demo switch.
      final String fullCode = _controllers.map((c) => c.text).join();
      if (fullCode.contains('2')) {
        context.push('/returning-checkout');
      } else {
        context.push('/guest-checkout');
      }
    }
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
                'Check your\ntexts.',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sent to +1 (647) 555-0192',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 46,
                    height: 58,
                    child: CupertinoTextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) => _onChanged(value, index),
                      style: const TextStyle(
                        fontFamily: AppTextStyles.fontFamilySyne,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: CupertinoColors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _controllers[index].text.isNotEmpty ? AppColors.primary : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                    children: [
                      TextSpan(text: 'Didn\'t get it? '),
                      TextSpan(
                        text: 'Resend →',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              IgnorePointer(
                ignoring: !_isVerifying,
                child: AnimatedOpacity(
                  opacity: _isVerifying ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(color: AppColors.primary, radius: 8),
                        SizedBox(width: 10),
                        Text(
                          'Verifying…',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamilySyne,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Auto-verifies when code arrives',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
