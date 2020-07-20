import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/tabs/tabs_bloc.dart';
import 'package:pureair/screens/screen_widget.dart';
import 'package:pureair/src/model/screen.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:pureair/widgets/pureair_bottom_nav_bar.dart';

class ScreenController extends StatefulWidget {
  @override
  _ScreenControllerState createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  TabsBloc get tabsBLoc => BlocProvider.of<TabsBloc>(context);
  Size get size => MediaQuery.of(context).size;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  Widget _icons(Screen screen) {
    switch (screen) {
      case Screen.home:
        return Icon(Icons.home);
        break;
      case Screen.search:
        return Icon(Icons.search);
        break;
      default:
        return Icon(Icons.settings);
    }
  }

  Widget _titles(Screen screen) {
    switch (screen) {
      case Screen.home:
        return Text(home.title.toUpperCase());
        break;
      case Screen.search:
        return Text(search.title.toUpperCase());
        break;
      default:
        return Text(settings.title.toUpperCase());
    }
  }

  List<PureBottomBarItem> _items() {
    List<PureBottomBarItem> _list = [];

    for (Screen screen in Screen.values) {
      _list.add(
        PureBottomBarItem(
          icon: _icons(screen),
          title: _titles(screen),
          activeColor: colorScheme.onBackground,
          inactiveColor: colorScheme.onBackground.withOpacity(0.5),
          textAlign: TextAlign.end,
        ),
      );
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocBuilder<TabsBloc, TabsState>(
        bloc: context.bloc<TabsBloc>(),
        builder: (context, state) {
          final selectedIndex = Screen.values.indexOf(state.widget.screen);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 12),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: state.widget.widget,
              ),
            ),
            appBar: PureAirAppBar(
              title: state.widget.title,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            bottomNavigationBar: PureAirBottomNavBar(
              size: size,
              items: _items(),
              selectedIndex: selectedIndex,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              showElevation: false,
              onSelected: (i) => tabsBLoc..add(UpdateTab(Screen.values[i])),
            ),
          );
        },
      ),
    );
  }
}

class ScreenClipper extends CustomPainter {
  final Color color;

  ScreenClipper(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    double sideWidth = 10;

    double clipHeight = size.height - (size.shortestSide * 0.16);

    double curve = 60;

    Path newPath = Path();
    newPath
      ..lineTo(0, size.height)
      // ..lineTo(0,size.height - (size.shortestSide * 0.16))
      ..lineTo(width, size.height)
      // ..lineTo(width, size.height - (size.shortestSide * 0.16))
      ..lineTo(width - curve, clipHeight)
      ..quadraticBezierTo(
          width - sideWidth, clipHeight + curve, width - sideWidth, clipHeight)
      // ..quadraticBezierTo(
      //     width - sideWidth, clipHeight, width - curve, clipHeight)

      //

      ..lineTo(sideWidth + curve, clipHeight)
      ..quadraticBezierTo(sideWidth, clipHeight, sideWidth, clipHeight - curve)
      ..lineTo(sideWidth, 0)
      ..close();

    Paint paint = Paint()..color = color;

    return canvas.drawPath(newPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
