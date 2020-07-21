import 'package:flutter/material.dart';

class ErrorSnackBar extends StatelessWidget {
  const ErrorSnackBar({
    Key key,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: size.shortestSide * 0.2,
      width: size.width,
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.92,
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: colorScheme.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          text,
          style: textTheme.headline6.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
