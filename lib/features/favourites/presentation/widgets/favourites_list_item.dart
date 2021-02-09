import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/screen_controller/widgets/pollutant_indicator.dart';
import '../../../../core/utils/aqi_level.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/fade_page_route.dart';
import '../../../search/domain/entities/search_data.dart';
import '../../../search/presentation/widgets/search_details_widget.dart';
import '../bloc/favourites_bloc.dart';

class FavouriteListItem extends StatelessWidget {
  const FavouriteListItem({Key key, @required this.city}) : super(key: key);
  final SearchData city;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final cubit = context.read<FavouritesBloc>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final mainContainerHeight = size.shortestSide * 0.25;
    final mainContainerWidth = size.width;

    final aqiSize = mainContainerHeight * 0.65;

    _onTap() {
      if (_getAqiValue() == null) {
        return null;
      } else {
        Navigator.of(context).push(
          FadePageRoute(
            widget: SearchDetailsWidget(data: city),
          ),
        );
      }
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: GestureDetector(
        onTap: () => _onTap(),
        child: Container(
          height: mainContainerHeight,
          width: mainContainerWidth,
          margin: EdgeInsets.only(top: 26),
          child: Material(
            color: colorScheme.background,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 18),
              child: Row(
                children: <Widget>[
                  _buildAqiIndex(aqiSize, _getAqiValue()),
                  SizedBox(width: 8),
                  Expanded(child: _buildCityName(theme, textTheme)),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    iconSize: 30,
                    color: colorScheme.error,
                    onPressed: () => cubit..add(RemoveFavourite(city: city)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getAqiValue() {
    if (city.aqi.contains('-') || city.aqi == null) {
      return 0;
    } else {
      final aqi = int.parse(city.aqi);
      return aqi;
    }
  }

  Widget _buildCityName(ThemeData theme, TextTheme textTheme) {
    AqiLevel level = getLevel(_getAqiValue());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          city.station.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline5.copyWith(fontSize: 18),
        ),
        Text(
          level.pollutionLevelToString,
          style: textTheme.bodyText2,
        ),
        SizedBox(height: 8),
        Text(
          dateFormatter(city.time.stime),
          style: textTheme.subtitle1.copyWith(
            fontSize: 14,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }

  Widget _buildAqiIndex(double aqiSize, int index) {
    return Container(
      height: aqiSize,
      width: aqiSize,
      child: PollutantIndicator(
        pollutantIndex: index,
        pollutantTitle: 'AQI',
      ),
    );
  }
}
