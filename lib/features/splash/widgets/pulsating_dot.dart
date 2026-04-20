import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';

class PulsatingDot extends StatefulWidget {
  final double size;
  const PulsatingDot({super.key, this.size = 14});

  @override
  State<PulsatingDot> createState() => _PulsatingDotState();
}

class _PulsatingDotState extends State<PulsatingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final scaleValue = 0.8 + (_animation.value * 0.4);
        final opacityValue = 0.6 + (_animation.value * 0.4);
        
        return Container(
          width: widget.size * scaleValue,
          height: widget.size * scaleValue,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: opacityValue),
            shape: BoxShape.circle,
            border: Border.all(
              color: CupertinoColors.black,
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4 * _animation.value),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
