import 'package:flutter/material.dart';
import 'package:pureair/src/model/aqi.dart';
class MoreInfoWidget extends StatelessWidget {
  const MoreInfoWidget({
    Key key,
    @required this.size,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  final Size size;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            child: Text(
              title,
              style: textTheme.subtitle1.copyWith(
                color: textTheme.headline6.color.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: textTheme.headline6.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreInfoList extends StatelessWidget {
  const MoreInfoList({
    Key key,
    @required this.size,
    @required this.model,
  }) : super(key: key);

  final Size size;
  final Aqi model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MoreInfoWidget(
          size: size,
          title: 'Dominant Pollutant',
          value: model.data.dominentpol.toUpperCase(),
        ),
        Divider(),
        MoreInfoWidget(
          size: size,
          title: 'Station',
          value: model.data.attributions[0].name,
        ),
      ],
    );
  }
}
