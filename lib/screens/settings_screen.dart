import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/theme/theme_bloc.dart';
import 'package:pureair/themes.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextTheme get textTheme => Theme.of(context).textTheme;
  Size get size => MediaQuery.of(context).size;

  final trailingIcon = Icon(Icons.chevron_right, size: 30);

  final contentPadding = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    Widget _buildListTile(String title, {bool enabled = false, Function() onTap}) {
      return Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          title: Text(
            title,
            style: textTheme.headline5.copyWith(
              fontWeight: FontWeight.w600,
              color: enabled
                  ? textTheme.headline6.color
                  : textTheme.headline6.color.withOpacity(0.3),
            ),
          ),
          enabled: enabled ?? false,
          contentPadding: contentPadding,
          trailing: trailingIcon,
          onTap: onTap,
        ),
      );
    }

    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 26),
        children: <Widget>[
          _CustomListTile(
            header: 'Account',
            content: <Widget>[
              _buildListTile('Create an account'),
            ],
          ),
          _CustomListTile(
            header: 'PREFERENCES',
            content: <Widget>[
              _buildListTile('Recommendations'),
              _buildListTile('Units'),
              _buildListTile('Sensitivity'),
              _buildListTile(
                'Theme',
                enabled: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectTheme(),
                    ),
                  );
                },
              ),
            ],
          ),
          _CustomListTile(
            header: 'NOTIFICATIONS',
            content: [
              _buildListTile('Favourite City'),
              _buildListTile('Smart notifications'),
              _buildListTile('Morning report'),
              _buildListTile('Evening report'),
            ],
          ),
          _CustomListTile(
            header: 'Help',
            content: <Widget>[
              _buildListTile('FAQ'),
              _buildListTile('Contact us'),
            ],
          ),
          _CustomListTile(
            header: 'LINKS',
            content: [
              _buildListTile('Shop'),
              _buildListTile('Legal'),
            ],
          ),
        ],
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
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    final headerStyle = textTheme.subtitle1.copyWith(
      color: textTheme.subtitle1.color.withOpacity(0.4),
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
    );

    return Container(
      padding: EdgeInsets.only(bottom: 50),
      child: StickyHeader(
        header: Container(
          color: theme.scaffoldBackgroundColor,
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

class SelectTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                ),
              ),
              contentPadding: listTilePadding,
              trailing: isSelected ? Icon(Icons.check) : null,
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
                ),
              ),
              contentPadding: listTilePadding,
              trailing: !isSelected ? Icon(Icons.check) : null,
              onTap: () {
                context.bloc<ThemeBloc>()
                  ..add(
                    ChangeTheme(ThemeEnum.darkTheme),
                  );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
