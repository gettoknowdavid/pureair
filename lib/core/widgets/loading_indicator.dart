import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key, this.height, this.width}) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
        child: Center(
          child: Material(
            child: Container(
              height: height ?? size.shortestSide * 0.25,
              width: width ?? size.shortestSide * 0.25,
              alignment: Alignment.center,
              padding: EdgeInsets.all(26),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  const BoxShadow(color: Colors.black12, blurRadius: 70),
                ],
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary
                  ],
                  begin: Alignment.topLeft,
                ),
              ),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
