import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/rekeva_card.dart';
import '../../../core/widgets/primary_button.dart';

class HealthReportScreen extends StatelessWidget {
  const HealthReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Tire Health'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Your tires are\nin good shape.',
                textAlign: TextAlign.center,
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 8),
              const Text(
                'Everything looks safe for winter.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subheadline,
              ),
              const SizedBox(height: 40),
              
              // Visual Health Chart
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 260,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  const Hero(
                    tag: 'car_icon',
                    child: Text('🚙', style: TextStyle(fontSize: 60)),
                  ),
                  // Tire Status Indicators
                  Positioned(top: 20, left: 30, child: _TireStatus(isGood: true)),
                  Positioned(top: 20, right: 30, child: _TireStatus(isGood: true)),
                  Positioned(bottom: 20, left: 30, child: _TireStatus(isGood: true)),
                  Positioned(bottom: 20, right: 30, child: _TireStatus(isGood: true)),
                ],
              ),
              
              const Spacer(),
              const RekevaCard(
                child: Row(
                  children: [
                    Icon(CupertinoIcons.info_circle, color: AppColors.primary),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Next suggested check: April 2026',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Got it →',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TireStatus extends StatelessWidget {
  final bool isGood;
  const _TireStatus({required this.isGood});

  @override
  Widget build(BuildContext context) {
    final color = isGood ? AppColors.primary : AppColors.warning;
    return Container(
      width: 32,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}
