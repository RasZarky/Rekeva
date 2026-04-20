import 'package:flutter/cupertino.dart';

class SilhouettePainter extends CustomPainter {
  final Color color;

  SilhouettePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Simple truck silhouette path (Hood, Cab, Bed)
    final path = Path()
      ..moveTo(2, 18) // Front bumper
      ..lineTo(22, 18) // Hood end
      ..lineTo(32, 6) // Windshield top
      ..lineTo(62, 6) // Roof end
      ..lineTo(62, 20) // Cab back
      ..lineTo(98, 20) // Bed end
      ..lineTo(98, 28) // Tailgate bottom
      ..lineTo(2, 28) // Front bottom
      ..close();

    canvas.drawPath(path, paint);

    // Wheels
    canvas.drawCircle(const Offset(22, 28), 6, paint);
    canvas.drawCircle(const Offset(82, 28), 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
