import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class VinEntryScreen extends StatefulWidget {
  const VinEntryScreen({super.key});

  @override
  State<VinEntryScreen> createState() => _VinEntryScreenState();
}

class _VinEntryScreenState extends State<VinEntryScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isValid = _controller.text.length >= 8; // Simplified validation
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
              const Text('What\'s your\nVIN?', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              const Text(
                'We\'ll find your exact fit.',
                style: AppTextStyles.subheadline,
              ),
              const SizedBox(height: 28),
              // VIN Input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VEHICLE IDENTIFICATION NUMBER',
                      style: AppTextStyles.caption.copyWith(fontSize: 10, color: AppColors.primary.withValues(alpha: 0.7)),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _controller,
                      autofocus: true,
                      placeholder: 'Enter 17 characters',
                      placeholderStyle: TextStyle(color: AppColors.textMuted, fontSize: 20),
                      style: const TextStyle(
                        fontFamily: AppTextStyles.fontFamilyDMSans,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: CupertinoColors.white,
                        letterSpacing: 2,
                      ),
                      decoration: null,
                      cursorColor: AppColors.primary,
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 17,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_controller.text.length} of 17 entered',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Help section
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📍', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Where to find it', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.white)),
                          SizedBox(height: 2),
                          Text(
                            'Dashboard, driver\'s side door frame, or your pink slip documents.',
                            style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Center(
                child: GestureDetector(
                  onTap: () => context.push('/door-jamb-scan'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('📷', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text('Scan door jamb instead', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _isValid ? () => context.push('/vin-lookup') : null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isValid ? AppColors.primary : AppColors.primary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    _isValid ? 'Look up vehicle →' : 'Enter VIN to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamilySyne,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _isValid ? CupertinoColors.black : CupertinoColors.black.withValues(alpha: 0.5),
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
