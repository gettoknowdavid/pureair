import 'package:flutter/material.dart';

class AirPurifierImage extends StatelessWidget {
  const AirPurifierImage({
    Key key,
    @required this.size,
    @required this.height,
    @required this.width,
    this.onPressed,
  }) : super(key: key);

  final Size size;
  final double height;
  final double width;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        borderRadius: BorderRadius.circular(60),
        elevation: 20,
        shadowColor: Colors.black26,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Container(
            color: Colors.white,
            child: Image.asset(
              'images/plume-labs-2.jpg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
