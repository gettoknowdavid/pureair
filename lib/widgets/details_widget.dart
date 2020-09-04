import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key key,
    @required this.size,
    @required this.title,
    this.content,
    this.addDivider = true,
  }) : super(key: key);

  final Size size;
  final String title;
  final Widget content;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    Widget divider() {
      if (addDivider)
        return Divider();
      else
        return Container();
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: textTheme.headline6.copyWith(
              color: colorScheme.onBackground.withOpacity(0.7),
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 26),
          content,
          SizedBox(height: 26),
          divider(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}