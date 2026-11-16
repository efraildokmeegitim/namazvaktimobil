import 'dart:math';
import 'package:flutter/material.dart';

/// Selçuklu 8 Köşeli Yıldızı Geometrik Arka Plan Deseni (Vektörel CustomPainter)
class SeljukPatternPainter extends CustomPainter {
  final Color strokeColor;
  final double strokeWidth;

  const SeljukPatternPainter({
    this.strokeColor = const Color(0x0A1FA87C), // Ultra-hafif zümrüt doku (%4 opaklık)
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const step = 64.0;
    for (double x = 0; x < size.width + step; x += step) {
      for (double y = 0; y < size.height + step; y += step) {
        _drawEightPointStar(canvas, Offset(x, y), 20.0, paint);
      }
    }
  }

  void _drawEightPointStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final rect1 = Rect.fromCenter(center: center, width: radius * 1.8, height: radius * 1.8);
    canvas.drawRect(rect1, paint);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pi / 4);
    final rect2 = Rect.fromCenter(center: Offset.zero, width: radius * 1.8, height: radius * 1.8);
    canvas.drawRect(rect2, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
