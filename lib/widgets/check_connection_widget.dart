import 'package:flutter/material.dart';

class CheckConnectionWidget extends StatelessWidget {
  const CheckConnectionWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: size.shortestSide * 0.3,
      width: size.width,
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.92,
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          'Please check your internet connection and try again.',
          style: textTheme.headline6.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
