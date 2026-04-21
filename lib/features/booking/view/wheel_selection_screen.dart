import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class WheelSelectionScreen extends StatefulWidget {
  const WheelSelectionScreen({super.key});

  @override
  State<WheelSelectionScreen> createState() => _WheelSelectionScreenState();
}

class _WheelSelectionScreenState extends State<WheelSelectionScreen> {
  final Set<int> _selectedWheels = {}; // 0: FL, 1: FR, 2: RL, 3: RR

  void _toggleWheel(int index) {
    setState(() {
      if (_selectedWheels.contains(index)) {
        _selectedWheels.remove(index);
      } else {
        _selectedWheels.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelection = _selectedWheels.isNotEmpty;

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
                  children: [
                    const Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    const Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Text('❄️ Complete My Set', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Which wheels\nneed new\nwinter tires?',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 10),
              const Text(
                'The others will get swapped from your existing set.',
                style: AppTextStyles.subheadline,
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Stack(
                    children: [
                      // Car Base SVG-like shape
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _CarBasePainter(),
                        ),
                      ),
                      // Wheel Targets
                      _WheelTarget(
                        top: 20, left: 20, label: 'FL',
                        isSelected: _selectedWheels.contains(0),
                        onTap: () => _toggleWheel(0),
                      ),
                      _WheelTarget(
                        top: 20, right: 20, label: 'FR',
                        isSelected: _selectedWheels.contains(1),
                        onTap: () => _toggleWheel(1),
                      ),
                      _WheelTarget(
                        bottom: 20, left: 20, label: 'RL',
                        isSelected: _selectedWheels.contains(2),
                        onTap: () => _toggleWheel(2),
                      ),
                      _WheelTarget(
                        bottom: 20, right: 20, label: 'RR',
                        isSelected: _selectedWheels.contains(3),
                        onTap: () => _toggleWheel(3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LegendItem(color: AppColors.primary, label: 'New tire needed'),
                  const SizedBox(width: 20),
                  _LegendItem(color: AppColors.border, label: 'Swap existing'),
                ],
              ),
              const Spacer(),
              if (hasSelection)
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.07),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedWheels.length} new · ${4 - _selectedWheels.length} swap · all 4 done',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const Text(
                        'From \$312',
                        style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: hasSelection ? () => context.push('/complete-set-catalogue') : null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: hasSelection ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(99),
                    border: hasSelection ? null : Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    'Pick my tires →',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamilySyne,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: hasSelection ? CupertinoColors.black : AppColors.textMuted,
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

class _WheelTarget extends StatelessWidget {
  final double? top, left, right, bottom;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _WheelTarget({this.top, this.left, this.right, this.bottom, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, left: left, right: right, bottom: bottom,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 72, height: 72,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withValues(alpha: 0.14) : AppColors.surface,
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: 2),
            borderRadius: BorderRadius.circular(14),
            boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.22), blurRadius: 18)] : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 34, height: 42,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 18, height: 30,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.textMuted,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isSelected ? 'NEW' : 'SWAP',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}

class _CarBasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final fillPaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;

    // Body
    final RRect body = RRect.fromLTRBR(100, 40, 200, 160, const Radius.circular(8));
    canvas.drawRRect(body, fillPaint);
    canvas.drawRRect(body, paint);

    // Front (SVG logic)
    final Path front = Path()
      ..moveTo(100, 40)
      ..quadraticBezierTo(150, 20, 200, 40)
      ..lineTo(200, 60)
      ..lineTo(100, 60)
      ..close();
    canvas.drawPath(front, fillPaint);
    canvas.drawPath(front, paint);

    // Rear
    final Path rear = Path()
      ..moveTo(100, 140)
      ..lineTo(200, 140)
      ..lineTo(200, 160)
      ..quadraticBezierTo(150, 180, 100, 160)
      ..close();
    canvas.drawPath(rear, fillPaint);
    canvas.drawPath(rear, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
