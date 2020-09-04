import 'package:flutter/material.dart';
import 'package:pureair/image_assets.dart';
import 'package:pureair/screens/screen_controller.dart';
import 'package:pureair/styles.dart';
import 'package:splashscreen/splashscreen.dart';

class PureAirSplashScreen extends StatelessWidget {
  const PureAirSplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterSeconds: ScreenController(),
      seconds: 5,
      title: Text(
        'PureAir',
        style: PureAirStyles.splashTitleStyle,
      ),
      image: appIcon,
      backgroundColor: Colors.white,
      photoSize: 100.0,
    );
  }
}
