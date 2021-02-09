import 'package:flutter/material.dart';

import '../widgets/select_condition.dart';
import '../widgets/settings_header_tile.dart';
import '../widgets/settings_sub_tile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.center,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: <Widget>[
              SizedBox(height: 30),
              SettingsHeaderTile(
                header: 'PREFERENCES',
                content: <Widget>[
                  SettingsSubTile(
                    title: 'Health Condition',
                    enabled: true,
                    widget: SelectCondition(),
                  ),
                ],
              ),
              SettingsHeaderTile(
                header: 'Account',
                content: <Widget>[
                  SettingsSubTile(title: 'Coming Soon!'),
                ],
              ),
              SettingsHeaderTile(
                header: 'Help',
                content: <Widget>[
                  SettingsSubTile(title: 'FAQ'),
                  SettingsSubTile(title: 'Contact us'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
