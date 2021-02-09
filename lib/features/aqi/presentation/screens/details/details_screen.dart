import 'package:flutter/material.dart';

import '../../../../../core/utils/aqi_level.dart';
import '../../../../../core/utils/get_health_recommendations.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../domain/entities/aqi.dart';
import '../../../domain/entities/aqi_by_condition.dart';
import '../../widgets/aqi_index_widget.dart';
import '../../widgets/location_widget.dart';
import 'widgets/detail_card.dart';
import 'widgets/dominant_pollutant_widget.dart';
import 'widgets/health_condition_widget.dart';
import 'widgets/more_info_list.dart';
import 'widgets/pollutant_grid.dart';
import 'widgets/weather_list.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, @required this.aqiByCondition})
      : super(key: key);

  final AqiByCondition aqiByCondition;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          height: size.height,
          width: size.width,
          color: theme.scaffoldBackgroundColor,
          child: _buildDetailsList(aqiByCondition.aqi),
        ),
      ),
    );
  }

  Widget _buildDetailsList(Aqi aqi) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocationAndDateWidget(aqi: aqi),
          SizedBox(height: 30),
          AqiIndexWidget(aqi: aqi),
          _RecAndDomPolCard(aqi: aqi),
          SizedBox(height: 30),
          HealthConditionWidget(),
          SizedBox(height: 30),
          PollutantsGrid(aqi: aqi),
          SizedBox(height: 40),
          WeatherList(aqi: aqi),
          SizedBox(height: 40),
          MoreInfoList(aqi: aqi),
        ],
      ),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return CustomAppBar(
      leading: CustomBackButton(),
      title: 'DETAILS',
      color: theme.scaffoldBackgroundColor,
    );
  }
}

class _RecAndDomPolCard extends StatelessWidget {
  const _RecAndDomPolCard({Key key, @required this.aqi}) : super(key: key);
  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final level = getLevel(aqi.data.aqi);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DetailCard(
        child: Column(
          children: [
            Text(
              getHealthRecs(level),
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: 18,
              ),
            ),
            Divider(height: 40),
            DominantPollutantWidget(aqi: aqi)
          ],
        ),
      ),
    );
  }
}
