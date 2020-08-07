import 'package:flutter/material.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class SelectUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listTilePadding = EdgeInsets.symmetric(
      vertical: 6,
    );
    bool isSelected = true;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar:
            PureAirAppBar(leading: PureAirBackButton(), title: 'SELECT UNIT'),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 26),
          children: <Widget>[
            ListTile(
              title: Text(
                'US EPA',
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
