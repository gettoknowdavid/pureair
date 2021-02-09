import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/favourites/presentation/screens/favourites_screen.dart';
import '../bottom_nav/bloc/bottom_nav_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/fade_page_route.dart';
import 'screen_enum.dart';
import 'widgets/bottom_nav_bar_container.dart';
import 'widgets/screen_body.dart';

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final screen = state.widget.screen;
        final title = state.widget.title;
        final child = state.widget.widget;

        final selectedIndex = ScreenEnum.values.indexOf(screen);

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _buildBody(child),
            appBar: _buildAppBar(context, title),
            bottomNavigationBar: _buildBottomNavBar(selectedIndex),
          ),
        );
      },
    );
  }

  ScreenBody _buildBody(Widget child) => ScreenBody(child: child);

  BottomNavBarContainer _buildBottomNavBar(int selectedIndex) {
    return BottomNavBarContainer(selectedIndex: selectedIndex);
  }

  CustomAppBar _buildAppBar(BuildContext context, String title) {
    final theme = Theme.of(context);

    return CustomAppBar(
      title: title,
      actions: IconButton(
        icon: Icon(Icons.favorite_border),
        color: theme.colorScheme.primary,
        onPressed: () {
          Navigator.of(context).push(FadePageRoute(widget: FavouritesScreen()));
        },
      ),
    );
  }
}
