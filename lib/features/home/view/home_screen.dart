import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/home_action_tile.dart';
import '../widgets/scan_door_jamb_card.dart';
import '../widgets/bottom_tab_mock.dart';
import '../widgets/seasonal_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamilySyne,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                            children: [
                              TextSpan(text: 'Rekeva'),
                              TextSpan(
                                text: '.',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement sign in logic
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text('Your car.\nYour tires.', style: AppTextStyles.headline),
                    const SizedBox(height: 8),
                    const Text(
                      'Tell us your vehicle and we\'ll take it from there.',
                      style: AppTextStyles.subheadline,
                    ),
                    const SizedBox(height: 32),
                    const ScanDoorJambCard(),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: HomeActionTile(
                            icon: '🔢',
                            label: 'Enter VIN',
                            onTap: () {
                              // VIN entry logic
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: HomeActionTile(
                            icon: '🔍',
                            label: 'Search',
                            onTap: () => context.push('/vehicle-search'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: HomeActionTile(
                            icon: '📄',
                            label: 'Pink slip',
                            onTap: () {
                              // Pink slip logic
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const SeasonalBanner(),
                    const SizedBox(height: 14),
                    const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'No account needed. Your data stays private',
                        style: AppTextStyles.subheadline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const BottomTabMock(),
          ],
        ),
      ),
    );
  }
}
