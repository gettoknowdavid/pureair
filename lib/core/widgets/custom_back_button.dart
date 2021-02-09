import 'package:flutter/material.dart';
import '../utils/pureaire_icons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key key, this.size, this.color}) : super(key: key);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: ImageIcon(
        backArrow,
        size: size ?? theme.iconTheme.size,
        color: color ?? theme.colorScheme.primary,
      ),
    );
  }
}
