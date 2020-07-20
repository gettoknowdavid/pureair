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
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: textTheme.headline6.copyWith(
          letterSpacing: 3,
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground.withOpacity(0.8),
        ),
      );
    }

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
      height: size.width * 0.26,
      width: size.width * 0.26,
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      // margin: EdgeInsets.only(bottom: 26),
      decoration: BoxDecoration(
        color: helper.backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.3),
            blurRadius: 20,
          ),
        ],
      ),
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

  Widget get _buildMainContainer {
    final dominantpol = widget.model.data.dominentpol.toUpperCase();
    return Container(
      width: size.width,
      padding: EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(60),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onBackground.withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: 30,
          ),
        ],
      ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Text(
                      'DOMINANT',
                      style: textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: textTheme.subtitle1.color.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$dominantpol is dominant in the air. This can cause bronchitis. Wear a mask to stay safe.',
                      softWrap: true,
                      maxLines: 4,
                      textAlign: TextAlign.start,
                      style: textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
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
          _buildMainContainer,
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
