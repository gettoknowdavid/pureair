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
      margin: EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              color: Colors.white,
              child: Image.asset(
                'images/plume-labs-2.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 86,
            left: 70,
            child: DefaultTextStyle(
              style: textTheme.headline6.copyWith(color: Color(0xFF08225E)),
              child: Row(
                children: <Widget>[
                  Text('&  '),
                  ImageIcon(
                    AssetImage('images/water.png'),
                    color: Color(0xFF08225E),
                  ),
                  Text('PureAir'),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            child: MaterialButton(
              onPressed: onPressed,
              color: Color(0xFF4478ff),
              height: size.shortestSide * 0.16,
              minWidth: size.shortestSide * 0.35,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              child: Text(
                'DISCOVER',
                style: textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
