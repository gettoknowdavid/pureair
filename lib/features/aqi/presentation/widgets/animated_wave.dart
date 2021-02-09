import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'curved_painter.dart';

class AnimatedWave extends StatelessWidget {
  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  final double height;
  final double speed;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: _buildLoopAnimation(),
      );
    });
  }

  LoopAnimation<double> _buildLoopAnimation() {
    return LoopAnimation<double>(
      duration: (5000 / speed).round().milliseconds,
      tween: 0.0.tweenTo(2 * pi),
      builder: (context, child, value) {
        return CustomPaint(
          foregroundPainter: CurvePainter(value + offset),
        );
      },
    );
  }
}

Widget buildWave(Widget child) {
  return Positioned.fill(
    child: Align(alignment: Alignment.bottomCenter, child: child),
  );
}
