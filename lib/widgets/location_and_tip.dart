import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';

class LocationAndTip extends StatelessWidget {
  const LocationAndTip({
    Key key,
    @required this.size,
    @required this.model,
  }) : super(key: key);

  final Size size;
  final Aqi model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    Text _buildHealthConcern(TextTheme textTheme) {
      final helper = AqiHelper(model);

      return Text(
        helper.healthConcern,
        style: textTheme.headline5.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: colorScheme.onBackground),
      );
    }

    Text _buidLocation(TextTheme textTheme) {
      return Text(
        '${model.data.city.name}'.toUpperCase(),
        maxLines: 3,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: textTheme.headline6.copyWith(
          fontSize: 16,
          letterSpacing: 3,
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground.withOpacity(0.8),
        ),
      );
    }

    return Container(
      width: size.width,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(26, 40, 26, 16),
      color: colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buidLocation(textTheme),
          SizedBox(height: 12),
          _buildHealthConcern(textTheme),
        ],
      ),
    );
  }
}