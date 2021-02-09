import 'dart:math';

import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    final color = Paint()..color = Color(0xFF1E1E1E).withOpacity(0.3);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = height * (0.1 + 0.15 * y1);
    final controlPointY = height * (0.1 + 0.15 * y2);
    final endPointY = height * (0.1 + 0.15 * y3);

    path.moveTo(width * 0, startPointY);
    path.quadraticBezierTo(width * 0.5, controlPointY, width, endPointY);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    canvas.drawPath(path, color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
