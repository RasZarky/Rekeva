import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class RekevaCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Border? border;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const RekevaCard({
    super.key,
    required this.child,
    this.color,
    this.border,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          HapticFeedback.lightImpact();
          onTap!();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: border ?? Border.all(color: AppColors.border),
        ),
        child: child,
      ),
    );
  }
}
