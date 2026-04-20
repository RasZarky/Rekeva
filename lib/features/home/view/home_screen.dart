import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/rekeva_card.dart';
import '../../booking/bloc/booking_bloc.dart';
import '../widgets/home_action_tile.dart';

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
                    const _ScanDoorJambCard(),
                    const SizedBox(height: 14),
                    Row(
                      children: const [
                        Expanded(child: HomeActionTile(icon: '🔢', label: 'Enter VIN')),
                        SizedBox(width: 8),
                        Expanded(child: HomeActionTile(icon: '🔍', label: 'Search')),
                        SizedBox(width: 8),
                        Expanded(child: HomeActionTile(icon: '📄', label: 'Pink slip')),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _SeasonalBanner(),
                    const SizedBox(height: 14),
                    Center(
                      child: const Text(
                        textAlign: TextAlign.center,
                        'No account needed. Your data stays private',
                        style: AppTextStyles.subheadline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const _BottomTabMock(),
          ],
        ),
      ),
    );
  }
}

class _ScanDoorJambCard extends StatefulWidget {
  const _ScanDoorJambCard();

  @override
  State<_ScanDoorJambCard> createState() => _ScanDoorJambCardState();
}

class _ScanDoorJambCardState extends State<_ScanDoorJambCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RekevaCard(
      color: AppColors.primaryGlow,
      border: Border.all(color: const Color(0x3822C55E), width: 1.5),
      onTap: () {
        context.push('/door-jamb-scan');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulsating big green circle behind the text
            Positioned(
              bottom: -20,
              right: 20,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_animation.value * 0.2),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.05 * _animation.value),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  // Camera container with ripples
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Ripples
                      for (var i = 1; i <= 2; i++)
                        Container(
                          width: 64.0 + (i * 16.0),
                          height: 64.0 + (i * 16.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.12 / i),
                          ),
                        ),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.camera_fill,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Scan door jamb',
                    style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Scan your door sticker',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeasonalBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Text('❄️', style: TextStyle(fontSize: 30)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Winter tire season is here',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 14),
                Text(
                  'Book before slots fill up in your area',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Icon(CupertinoIcons.right_chevron, size: 14, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _BottomTabMock extends StatelessWidget {
  const _BottomTabMock();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _TabItem(
            icon: CupertinoIcons.house_fill,
            label: 'Home',
            isActive: true,
            onTap: () => context.go('/home'),
          ),
          _TabItem(
            icon: CupertinoIcons.calendar,
            label: 'Appointments',
            onTap: () {
              // Placeholder for S-19 Your appointments
              // context.push('/appointments'); 
            },
          ),
          _TabItem(
            icon: CupertinoIcons.person,
            label: 'Account',
            onTap: () {
              // Placeholder for S-21 Account
              // context.push('/profile');
            },
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? AppColors.primary : AppColors.textMuted,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? AppColors.primary : AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
