import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.borderRadius = 30,
    this.horizontalPadding,
    this.verticalPadding,
  }) : super(key: key);

  final Widget child;
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: color ?? theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20,
          vertical: verticalPadding ?? 26,
        ),
        child: child,
      ),
    );
  }
}
