import 'package:flutter/material.dart';

class CheckConnectionWidget extends StatelessWidget {
  const CheckConnectionWidget({Key key, this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: size.shortestSide * 0.3,
        width: size.width,
        alignment: Alignment.topCenter,
        child: Container(
          height: size.height * 0.1,
          width: size.width * 0.92,
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            message ?? 'Please check your internet connection and try again.',
            style: theme.textTheme.headline6.copyWith(
              fontSize: 18,
              color: theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
