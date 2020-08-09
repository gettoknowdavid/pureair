import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/screens/select_health_condition.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/dominant_pollutant.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/more_info_widget.dart';
import 'package:pureair/widgets/pollutant_widget.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:pureair/widgets/recommendations_widget.dart';
import 'package:pureair/widgets/weather_widget.dart';

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

class _LocationAndTip extends StatelessWidget {
  const _LocationAndTip({
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
            // fontSize: 250,
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
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 36,
              padding: EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget.situation.index != 0
                  ? AutoSizeText(
                      enumToString(widget.situation),
                      style: textTheme.headline6.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          FadePageRoute(widget: SelectHealthCondition()),
                        );
                      },
                      child: AutoSizeText(
                        'Click to select a health situation',
                        style: textTheme.headline6.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 30),
            widget.situation.index != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.message}',
                        style: textTheme.headline6,
                      ),
                      SizedBox(height: 30),
                      LimitedBox(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 25,
                          ),
                          itemCount: widget.pollutants.length,
                          itemBuilder: (context, index) {
                            final titles = widget.pollutants[index].keys;
                            final values = widget.pollutants[index].values;
                            title() {
                              String title;
                              for (String _title in titles) {
                                switch (_title) {
                                  case 'co':
                                    return title = 'CO';
                                  case 'o3':
                                    return title = 'O\u2083';
                                  case 'no2':
                                    return title = 'NO\u2082';
                                  case 'pm10':
                                    return title = 'PM10';
                                  case 'pm25':
                                    return title = 'PM2.5';
                                  default:
                                    return title = 'SO\u2082';
                                }
                              }
                              return title;
                            }

                            value() {
                              String value;
                              for (String _value in values) value = _value;
                              return value;
                            }

                            return PollutantWidget(
                              size: size,
                              title: title(),
                              value: value(),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      'Select your preferred health situation to see air pollutants tailored to your health situation.',
                      style: textTheme.bodyText2.copyWith(
                          fontSize: 18,
                          color: colorScheme.onBackground.withOpacity(0.7)),
                    ),
                  ),
          ],
        ),
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
            _LocationAndTip(
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
            child: ListView(
              shrinkWrap: true,
              children: _buildList,
            ),
          ),
        ),
      ),
    );
  }
}
