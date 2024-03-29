import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key key,
    @required this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final _style = textTheme.headline5.copyWith(
      fontWeight: FontWeight.w600,
      color: colorScheme.onBackground,
    );

    final listTilePadding = EdgeInsets.symmetric(vertical: 6);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ListTile(
        title: Text(title, style: _style),
        contentPadding: listTilePadding,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
