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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rekeva.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  Icon(CupertinoIcons.person_crop_circle_fill, size: 34, color: AppColors.surfaceLight),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Your car.\nYour tires.', style: AppTextStyles.headline),
              const SizedBox(height: 8),
              const Text('Tell us your vehicle and we\'ll take it from there.', style: AppTextStyles.subheadline),
              const SizedBox(height: 32),
              
              RekevaCard(
                color: AppColors.primaryGlow,
                border: Border.all(color: const Color(0x3822C55E), width: 1.5),
                onTap: () {
                  context.read<BookingBloc>().setVehicle('Toyota RAV4');
                  context.push('/service-select');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Container(
                        width: 64, height: 64,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(CupertinoIcons.camera_fill, color: CupertinoColors.black),
                      ),
                      const SizedBox(height: 16),
                      const Text('Scan door jamb', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const Text('Scan your door sticker', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              
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
              
              const Spacer(),
              _SeasonalBanner(),
              const SizedBox(height: 20),
              const _BottomTabMock(),
            ],
          ),
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
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: const Row(
        children: [
          Text('❄️', style: TextStyle(fontSize: 20)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Winter tire season is here', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text('Book before slots fill up', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _TabItem(icon: CupertinoIcons.house_fill, label: 'Home', isActive: true),
        _TabItem(icon: CupertinoIcons.calendar, label: 'Appts'),
        _TabItem(icon: CupertinoIcons.person, label: 'Account'),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _TabItem({required this.icon, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: isActive ? AppColors.primary : AppColors.textMuted),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: isActive ? AppColors.primary : AppColors.textMuted, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
