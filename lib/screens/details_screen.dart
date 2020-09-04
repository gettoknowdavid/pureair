import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/screens/select_health_condition.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/details_widget.dart';
import 'package:pureair/widgets/dominant_pollutant.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/health_situation_button.dart';
import 'package:pureair/widgets/health_situation_grid.dart';
import 'package:pureair/widgets/health_situation_widget.dart';
import 'package:pureair/widgets/location_and_tip.dart';
import 'package:pureair/widgets/more_info_widget.dart';
import 'package:pureair/widgets/pollutant_widget.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:pureair/widgets/recommendations_widget.dart';
import 'package:pureair/widgets/weather_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key key,
    @required this.model,
    @required this.situation,
    @required this.message,
    @required this.pollutants,
  }) : super(key: key);

  final Aqi model;
  final SituationEnum situation;
  final String message;
  final List<Map<String, String>> pollutants;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Size get size => MediaQuery.of(context).size;
  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
  AqiHelper get helper => AqiHelper(widget.model);

  PureAirAppBar get _buildAppBar {
    return PureAirAppBar(
      leading: PureAirBackButton(),
      title: 'DETAILS',
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
    );
  }

  Widget get _buildAqiValue {
    return Material(
      color: helper.backgroundColor,
      borderRadius: BorderRadius.circular(20),
      elevation: 20,
      shadowColor: Colors.black38,
      child: Container(
        height: size.width * 0.2,
        width: size.width * 0.2,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: AutoSizeText(
          '${widget.model.data.aqi}',
          maxLines: 1,
          softWrap: false,
          textAlign: TextAlign.center,
          style: textTheme.headline1.copyWith(
            fontWeight: FontWeight.w900,
            color: helper.color,
          ),
        ),
      ),
    );
  }

  DetailsWidget get _buildMoreInfoList {
    return DetailsWidget(
      addDivider: false,
      size: size,
      title: 'MORE INFO',
      content: MoreInfoList(
        size: size,
        model: widget.model,
      ),
    );
  }

  DetailsWidget get _buildWeatherList {
    return DetailsWidget(
      size: size,
      title: 'WEATHER',
      content: WeatherList(size: size, model: widget.model),
    );
  }

  DetailsWidget get _buildRecommendations {
    return DetailsWidget(
      size: size,
      title: 'RECOMMENDATIONS',
      content: RecommendationsList(
        model: widget.model,
        size: size,
      ),
    );
  }

  DetailsWidget get _buildPollutantList {
    return DetailsWidget(
      size: size,
      title: 'POLLUTANTS',
      content: PollutantList(
        size: size,
        model: widget.model,
      ),
    );
  }

  DetailsWidget get _buildHealthSituation {
    return DetailsWidget(
      size: size,
      title: 'HEALTH SITUATION',
      content: HealthSituationWidget(
        message: widget.message,
        pollutants: widget.pollutants,
        situation: widget.situation,
        size: size,
      ),
    );
  }

  Widget get _buildMainContainer {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black12,
      elevation: 40,
      shadowColor: Colors.black,
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildAqiValue,
                Container(
                  height: 70,
                  width: 2,
                  margin: EdgeInsets.fromLTRB(12, 7, 12, 0),
                  decoration: BoxDecoration(
                    color: colorScheme.onBackground.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Expanded(
                  child: DominantPollutant(
                    helper: helper,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            _buildHealthSituation,
            _buildPollutantList,
            _buildRecommendations,
            _buildWeatherList,
            _buildMoreInfoList,
          ],
        ),
      ),
    );
  }

  List<Widget> get _buildList {
    return [
      Container(
        color: colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            LocationAndTip(
              size: size,
              model: widget.model,
            ),
            _buildMainContainer,
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: _buildAppBar,
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: ListView(shrinkWrap: true, children: _buildList),
          ),
        ),
      ),
    );
  }
}
