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
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
          ),
        ],
      ),
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
    );
  }
}
