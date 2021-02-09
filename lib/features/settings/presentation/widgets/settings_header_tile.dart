import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SettingsHeaderTile extends StatelessWidget {
  const SettingsHeaderTile({Key key, @required this.header, this.content})
      : super(key: key);

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

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: StickyHeader(
          header: Container(
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
      ),
    );
  }
}
