import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bottom_nav/bloc/bottom_nav_bloc.dart';
import '../../bottom_nav/widgets/bottom_nav_bar.dart';
import '../../bottom_nav/widgets/bottom_nav_bar_item.dart';
import '../screen_enum.dart';
import 'screen_widget.dart';

class BottomNavBarContainer extends StatelessWidget {
  const BottomNavBarContainer({Key key, @required this.selectedIndex})
      : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(
      items: _items(context),
      selectedIndex: selectedIndex,
      onSelected: (i) {
        context.read<BottomNavBloc>()
          ..add(UpdateBottomNav(ScreenEnum.values[i]));
      },
    );
  }

  Widget _icons(ScreenEnum screen) {
    switch (screen) {
      case ScreenEnum.home:
        return Icon(Icons.home);
        break;
      case ScreenEnum.search:
        return Icon(Icons.search);
        break;
      default:
        return Icon(Icons.settings);
    }
  }

  List<BottomNavBarItem> _items(BuildContext context) {
    final theme = Theme.of(context);

    List<BottomNavBarItem> _list = [];

    for (ScreenEnum screen in ScreenEnum.values) {
      _list.add(
        BottomNavBarItem(
          icon: _icons(screen),
          title: _titles(screen),
          activeColor: theme.colorScheme.primary,
          inactiveColor: theme.colorScheme.onBackground.withOpacity(0.4),
        ),
      );
    }
    return _list;
  }

  Widget _titles(ScreenEnum screen) {
    switch (screen) {
      case ScreenEnum.home:
        return Text(home.title.toUpperCase());
        break;
      case ScreenEnum.search:
        return Text(search.title.toUpperCase());
        break;
      default:
        return Text(settings.title.toUpperCase());
    }
  }
}
