import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ShopProfileScreen extends StatelessWidget {
  final String shopName;

  const ShopProfileScreen({super.key, required this.shopName});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shop photo header (Simulated)
                _buildHeader(context),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shop name + rating
                      _buildShopTitle(),
                      const SizedBox(height: 16),

                      // Quick stats
                      _buildStatsRow(),
                      const SizedBox(height: 24),

                      // Services offered
                      _buildServicesSection(),
                      const SizedBox(height: 24),

                      // Hours
                      _buildHoursSection(),
                      const SizedBox(height: 24),

                      // Recent reviews
                      _buildReviewsSection(),
                      const SizedBox(height: 120), // Space for bottom gradient + CTA
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Persistent Bottom CTA with Gradient Overlay
          _buildBottomCTA(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A2A1A), Color(0xFF0A1A0A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withValues(alpha: 0.15), CupertinoColors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(child: Text('🔧', style: TextStyle(fontSize: 48))),
            ),
          ),
          // Back Button Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: CupertinoColors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.left_chevron, size: 12, color: CupertinoColors.white),
                      SizedBox(width: 4),
                      Text('Back', style: TextStyle(color: CupertinoColors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Open Badge
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(99),
              ),
              child: const Text(
                'Open now',
                style: TextStyle(color: CupertinoColors.black, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(shopName, style: AppTextStyles.headline.copyWith(fontSize: 22)),
              const SizedBox(height: 4),
              const Text(
                '1234 Erin Mills Pkwy · 2.1 km away',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '4.9',
              style: TextStyle(
                fontFamily: AppTextStyles.fontFamilySyne,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const Text(
              '142 reviews',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: const [
        Expanded(child: _StatBox(value: '847', label: 'Rekeva jobs', isPrimary: true)),
        SizedBox(width: 8),
        Expanded(child: _StatBox(value: '4', label: 'Service bays')),
        SizedBox(width: 8),
        Expanded(child: _StatBox(value: '12y', label: 'In business')),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SERVICES', style: AppTextStyles.caption),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: const [
            _ServiceChip(label: '❄️ Seasonal Swap'),
            _ServiceChip(label: '⚙️ Fit My Tires'),
            _ServiceChip(label: '🛒 New Tires'),
          ],
        ),
      ],
    );
  }

  Widget _buildHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('HOURS', style: AppTextStyles.caption),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: const [
              _HourRow(days: 'Mon – Fri', hours: '8:00 AM – 6:00 PM'),
              SizedBox(height: 8),
              _HourRow(days: 'Saturday', hours: '8:00 AM – 4:00 PM'),
              SizedBox(height: 8),
              _HourRow(days: 'Sunday', hours: 'Closed', isClosed: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('RECENT REVIEWS', style: AppTextStyles.caption),
        const SizedBox(height: 12),
        const _ReviewCard(
          name: 'Maria T.',
          comment: 'In and out in 45 min. Super professional, showed me the torque specs before I left.',
        ),
        const SizedBox(height: 8),
        const _ReviewCard(
          name: 'James K.',
          comment: 'Booked through Rekeva, seamless. They even noticed my tire pressure was off and fixed it.',
        ),
      ],
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background.withValues(alpha: 0), AppColors.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.push('/time-selection', extra: shopName),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              'Book at $shopName →',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTextStyles.fontFamilySyne,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: CupertinoColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final bool isPrimary;
  const _StatBox({required this.value, required this.label, this.isPrimary = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: AppTextStyles.fontFamilySyne,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: isPrimary ? AppColors.primary : CupertinoColors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
      ],
    ),
  );
}

class _ServiceChip extends StatelessWidget {
  final String label;
  const _ServiceChip({required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: 0.1),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      label,
      style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600),
    ),
  );
}

class _HourRow extends StatelessWidget {
  final String days;
  final String hours;
  final bool isClosed;
  const _HourRow({required this.days, required this.hours, this.isClosed = false});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(days, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      Text(
        hours,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isClosed ? AppColors.textMuted : CupertinoColors.white,
        ),
      ),
    ],
  );
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String comment;
  const _ReviewCard({required this.name, required this.comment});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.2), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(
                name[0],
                style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.white)),
            const Spacer(),
            const Text('★★★★★', style: TextStyle(color: AppColors.primary, fontSize: 10)),
          ],
        ),
        const SizedBox(height: 8),
        Text(comment, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.5)),
      ],
    ),
  );
}
