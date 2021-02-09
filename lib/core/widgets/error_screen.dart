import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Center(
          child: Container(
            height: size.shortestSide * 0.4,
            width: size.shortestSide * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 70,
                ),
              ],
            ),
            child: Card(
              elevation: 200,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.headline5.copyWith(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
