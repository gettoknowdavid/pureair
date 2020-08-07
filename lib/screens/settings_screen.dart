import 'package:flutter/material.dart';
import 'package:pureair/screens/favourites_settings_screen.dart';
import 'package:pureair/screens/select_health_condition.dart';
import 'package:pureair/screens/select_theme.dart';
import 'package:pureair/screens/select_unit.dart';
import 'package:pureair/widgets/settings_tile.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
  Size get size => MediaQuery.of(context).size;

  final contentPadding = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF2F2F2),

      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            SizedBox(height: 30),
            _CustomListTile(
              header: 'PREFERENCES',
              content: <Widget>[
                SettingsTile(
                  title: 'Health Condition',
                  enabled: true,
                  widget: SelectHealthCondition(),
                ),
                SettingsTile(
                  title: 'Favourite City',
                  enabled: true,
                  widget: FavouritesSettings(),
                ),
                SettingsTile(
                  title: 'Units',
                  enabled: true,
                  widget: SelectUnit(),
                ),
                SettingsTile(
                  title: 'Theme',
                  enabled: true,
                  widget: SelectTheme(),
                ),
              ],
            ),
            _CustomListTile(
              header: 'Account',
              content: <Widget>[
                SettingsTile(title: 'Coming Soon!'),
              ],
            ),
            _CustomListTile(
              header: 'Help',
              content: <Widget>[
                SettingsTile(title: 'FAQ'),
                SettingsTile(title: 'Contact us'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    Key key,
    @required this.header,
    this.content,
  }) : super(key: key);

  final String header;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;

    final headerStyle = textTheme.subtitle1.copyWith(
      color: textTheme.subtitle1.color.withOpacity(0.4),
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
    );

    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: StickyHeader(
        header: Container(
          // color: theme.scaffoldBackgroundColor,
          alignment: Alignment.centerLeft,
          width: width,
          height: width * 0.13,
          child: Text(
            header.toUpperCase(),
            style: headerStyle,
          ),
        ),
        content: Column(
          children: content == null ? [] : content
            ..add(Divider()),
        ),
      ),
    );
  }
}
