import 'package:flutter/material.dart';

class GradientConditionButton extends StatelessWidget {
  const GradientConditionButton({
    Key key,
    @required this.title,
    this.height,
    this.onTap,
  }) : super(key: key);

  final double height;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: theme.textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
