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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    final theme = Theme.of(context);

    Color mainColor =
        theme.brightness == Brightness.light ? Colors.white : Colors.black;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocBuilder<TabsBloc, TabsState>(
        bloc: context.bloc<TabsBloc>(),
        builder: (context, state) {
          final selectedIndex = Screen.values.indexOf(state.widget.screen);
          return Scaffold(
            key: _scaffoldKey,
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 12),
              color: mainColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: state.widget.widget,
              ),
            ),
            appBar: PureAirAppBar(
              title: state.widget.title,
              color: mainColor,
            ),
            bottomNavigationBar: PureAirBottomNavBar(
              size: size,
              items: _items(),
              selectedIndex: selectedIndex,
              backgroundColor: mainColor,
              showElevation: false,
              onSelected: (i) => tabsBLoc..add(UpdateTab(Screen.values[i])),
            ),
          );
        },
      ),
    );
  }
}

