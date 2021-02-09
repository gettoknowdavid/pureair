import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/aqi.dart';

class BriefDetailsWidget extends StatelessWidget {
  const BriefDetailsWidget({Key key, @required this.aqi, @required this.onTap})
      : super(key: key);
  final Aqi aqi;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
        borderRadius: BorderRadius.circular(36),
        color: theme.colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(36),
          child: _buildMainContainer(context),
        ),
      ),
    );
  }

  Container _buildMainContainer(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.2,
      width: width * 0.87,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('SHOWING NEAREST LOCATION', style: theme.textTheme.caption),
          _buildCityName(theme),
          _buildDate(theme),
          SizedBox(height: 10),
          Text('TAP TO LEARN MORE', style: theme.textTheme.bodyText2),
        ],
      ),
    );
  }

  Text _buildDate(ThemeData theme) {
    return Text(
      dateFormatter(aqi.data.time.iso),
      style: theme.textTheme.headline6.copyWith(
        color: theme.colorScheme.onBackground,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Container _buildCityName(ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(bottom: 6, top: 12),
      child: Text(
        aqi.data.city.name,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.headline5,
      ),
    );
  }
}
