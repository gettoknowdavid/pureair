import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: size.shortestSide * 0.35,
          width: size.shortestSide * 0.35,
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
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
