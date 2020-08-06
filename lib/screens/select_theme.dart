import 'package:flutter/material.dart';
import 'package:pureair/blocs/theme/theme_bloc.dart';
import 'package:pureair/themes.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SelectTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listTilePadding = EdgeInsets.symmetric(
      vertical: 6,
    );
    bool isSelected = Theme.of(context).brightness == Brightness.light;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PureAirAppBar(leading: PureAirBackButton()),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: <Widget>[
            ListTile(
              title: Text(
                'Light Theme',
                style: textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ),
              ),
              contentPadding: listTilePadding,
              trailing: isSelected
                  ? Icon(
                      Icons.check,
                      color: colorScheme.primary,
                    )
                  : null,
              onTap: () {
                context.bloc<ThemeBloc>().add(
                      ChangeTheme(ThemeEnum.lightTheme),
                    );
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Dark Theme',
                style: textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ),
              ),
              contentPadding: listTilePadding,
              trailing: !isSelected
                  ? Icon(
                      Icons.check,
                      color: colorScheme.primary,
                    )
                  : null,
              onTap: () {
                context.bloc<ThemeBloc>()
                  ..add(
                    ChangeTheme(ThemeEnum.darkTheme),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
