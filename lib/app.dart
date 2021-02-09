import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/widgets/app_splash_screen.dart';
import 'theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: AppSplashScreen(),
    );
  }
}
