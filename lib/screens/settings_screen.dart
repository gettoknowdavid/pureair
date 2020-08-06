import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/situation/situation_bloc.dart';
import 'package:pureair/screens/select_theme.dart';
import 'package:pureair/src/model/situation.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
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
    Widget _buildListTile(String title,
        {bool enabled = false, Function() onTap}) {
      final trailingIcon = Icon(
        Icons.chevron_right,
        size: 30,
        color: enabled
            ? colorScheme.primary
            : colorScheme.primary.withOpacity(0.2),
      );
      return Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          title: Text(
            title,
            style: textTheme.headline5.copyWith(
              fontWeight: FontWeight.w600,
              color: enabled
                  ? colorScheme.onBackground
                  : colorScheme.onBackground.withOpacity(0.3),
            ),
          ),
          enabled: enabled ?? false,
          contentPadding: contentPadding,
          trailing: trailingIcon,
          onTap: onTap,
        ),
      );
    }

    return Scaffold(
      // backgroundColor: Color(0xFFF2F2F2),

      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            SizedBox(height: 20),
            _CustomListTile(
              header: 'Account',
              content: <Widget>[
                _buildListTile('Create an account'),
              ],
            ),
            _CustomListTile(
              header: 'PREFERENCES',
              content: <Widget>[
                _buildListTile(
                  'Health Condition',
                  enabled: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectHealthCondition(),
                      ),
                    );
                  },
                ),
                _buildListTile(
                  'Units',
                  enabled: true,
                ),
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
      padding: EdgeInsets.only(bottom: 50),
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

class SelectHealthCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listTilePadding = EdgeInsets.symmetric(
      vertical: 6,
    );

    ListTile _buildListTile(SituationEnum situation,
        {bool isSelected: false, VoidCallback onTap}) {
      return ListTile(
        title: Text(
          enumToString(situation),
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
        onTap: onTap,
      );
    }

    return BlocBuilder<SituationBloc, SituationState>(
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: PureAirAppBar(leading: PureAirBackButton()),
            body: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemCount: SituationEnum.values.length,
              itemBuilder: (context, index) {
                return _buildListTile(
                  SituationEnum.values[index],
                  isSelected: (state as SituationLoaded).situation ==
                      SituationEnum.values[index],
                  onTap: () {
                    context.bloc<SituationBloc>()
                      ..add(
                        UpdateSituation(
                          SituationEnum.values[index],
                        ),
                      );
                  },
                );
              },
            ),
            // body: ListView(
            //   padding: EdgeInsets.symmetric(horizontal: 24),
            //   children: <Widget>[
            //     _buildListTile('Asthma'),
            //     Divider(),
            //     _buildListTile('Bronchitis'),
            //     Divider(),
            //     _buildListTile('Lung Cancer'),
            //     Divider(),
            //     _buildListTile('Emphysema'),
            //     Divider(),
            //     _buildListTile('High Blood Pressure'),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}

String enumToString(dynamic input) {
  String name = input.toString().split('.').last;
  // String firstLetter = name[0].toUpperCase();
  // final otherLetters = name.split(name[0]);
  if (name == 'asthma')
    return 'Asthma';
  else if (name == 'bronchitis')
    return 'Bronchitis';
  else if (name == 'emphysema')
    return 'Emphysema';
  else if (name == 'lungCancer')
    return 'Lung Cancer';
  else if (name == 'hbp')
    return 'High Blood Pressure';
  else
    return 'None';
}
// String enumFormatter(dynamic input) {
//   final name = enumToString(input);
//   if ()
// }
