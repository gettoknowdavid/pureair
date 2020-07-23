import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  // const LoadingIndicator({
  //   Key key,
  //   this.size,
  // }) : super(key: key);

  // final Size size;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.shortestSide * 0.25,
          width: size.shortestSide * 0.25,
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
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(26),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
