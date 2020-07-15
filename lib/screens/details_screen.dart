import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/widgets/custom_back_button.dart';
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
  }) : super(key: key);

  final Size size;
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: textTheme.headline6.copyWith(
              color: textTheme.headline6.color.withOpacity(0.8),
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 26),
          content,
          SizedBox(height: 26),
          Divider(),
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

    return Container(
      width: size.width,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(26),
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

  Text _buildHealthConcern(TextTheme textTheme) {
    final helper = AqiHelper(model);

    return Text(
      helper.healthConcern,
      style: textTheme.headline5.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text _buidLocation(TextTheme textTheme) {
    return Text(
      '${model.data.city.name}'.toUpperCase(),
      style: textTheme.headline6.copyWith(
        letterSpacing: 3,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key, @required this.model}) : super(key: key);

  final Aqi model;

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
    );
  }

  Widget get _buildAqiValue {
    return Container(
      height: size.width * 0.27,
      width: size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(bottom: 26),
      child: AutoSizeText(
        '${widget.model.data.aqi}',
        maxLines: 1,
        softWrap: false,
        style: textTheme.headline1.copyWith(
          fontSize: 300,
          fontWeight: FontWeight.w900,
          color: helper.backgroundColor,
        ),
      ),
    );
  }

  DetailsWidget get _buildMoreInfoList {
    return DetailsWidget(
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

  Widget get _buildMainContainer {
    return Container(
      width: size.width,
      padding: EdgeInsets.all(26),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[200]
          : colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAqiValue,
          _buildPollutantList,
          _buildRecommendations,
          _buildWeatherList,
          _buildMoreInfoList,
        ],
      ),
    );
  }

  List<Widget> get _buildList {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _LocationAndTip(
            size: size,
            model: widget.model,
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(60),
            ),
            child: _buildMainContainer,
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: _buildAppBar,
        body: ListView(
          shrinkWrap: true,
          children: _buildList,
        ),
      ),
    );
  }
}
