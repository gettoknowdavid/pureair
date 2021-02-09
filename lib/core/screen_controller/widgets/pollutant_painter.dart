import 'package:flutter/material.dart';

class PollutantPainter extends CustomPainter {
  PollutantPainter({this.index, this.color});
  final int index;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final _aqi = index.toDouble();
    final _aqiPercentage = (_aqi / 500.0);

    var p1 = Offset(size.width, 0);
    var p2 = Offset(size.width, (_aqiPercentage * size.height));

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    var backP1 = Offset(size.width, size.height);
    var backP2 = Offset(size.width, 0);

    Paint backPaint = Paint()
      ..color = Color(0xFF4C4C4C)
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(backP1, backP2, backPaint);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
