import 'package:flutter/material.dart';

class MoreInfoWidget extends StatelessWidget {
  const MoreInfoWidget({Key key, @required this.title, @required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(vertical: 6),
        child: _buildRow(context),
      ),
    );
  }

  Row _buildRow(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(textTheme, colorScheme),
        SizedBox(width: 20),
        _buildValue(textTheme, colorScheme),
      ],
    );
  }

  Container _buildTitle(TextTheme textTheme, ColorScheme colorScheme) {
    final _style = textTheme.subtitle1.copyWith(
      color: colorScheme.onBackground.withOpacity(0.7),
      fontSize: 14,
      letterSpacing: 0.4,
    );

    return Container(
      width: 100,
      child: Text(title, style: _style),
    );
  }

  Widget _buildValue(TextTheme textTheme, ColorScheme colorScheme) {
    return Expanded(
      child: Text(
        value,
        maxLines: 3,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: textTheme.headline6.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onBackground,
          fontSize: 18
        ),
      ),
    );
  }
}
