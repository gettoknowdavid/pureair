import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/aqi.dart';

class LocationAndDateWidget extends StatelessWidget {
  const LocationAndDateWidget({Key key, @required this.aqi}) : super(key: key);

  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            aqi.data.city.name,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headline5.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            dateFormatter(aqi.data.time.iso),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.subtitle1.copyWith(
              color: const Color(0xFF858585),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
