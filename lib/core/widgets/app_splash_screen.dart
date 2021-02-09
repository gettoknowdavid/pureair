import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../screen_controller/screen_controller.dart';
import '../utils/pureaire_icons.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterSeconds: ScreenController(),
      seconds: 5,
      title: Text(
        'PureAir',
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
      image: Image.asset(appIcon.assetName),
      backgroundColor: Color(0xFF101010),
      photoSize: 100.0,
      loaderColor: Color(0xFFED44E1),
    );
  }
}
