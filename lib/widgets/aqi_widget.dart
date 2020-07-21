import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/screens/details_screen.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/widgets/animated_wave.dart';
import 'package:pureair/widgets/date_formatter.dart';
import 'package:pureair/widgets/fade_page_route.dart';

class AqiWidget extends StatefulWidget {
  final double width;
  final double height;
  final Aqi model;
  final AqiHelper helper;

  const AqiWidget({
    Key key,
    @required this.model,
    @required this.width,
    @required this.height,
    this.helper,
  }) : super(key: key);
  @override
  _AqiWidgetState createState() => _AqiWidgetState();
}

class _AqiWidgetState extends State<AqiWidget> {
  TextTheme get textTheme => Theme.of(context).textTheme;

  Widget onBottom(Widget child) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: child,
      ),
    );
  }

  Widget get _buildAqiValue {
    return Container(
      // height: widget.width * 0.75,
      width: widget.width,
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: AutoSizeText(
        '${widget.model.data.aqi}',
        maxLines: 1,
        softWrap: false,
        minFontSize: 180,
        // maxFontSize: 300,
        style: textTheme.headline1.copyWith(
          fontSize: 250,
          fontWeight: FontWeight.w900,
          color: widget.helper.color,
        ),
      ),
    );
  }

  Widget get _buildHealthTip {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Text(
        '${widget.helper.healthConcern}',
        textAlign: TextAlign.center,
        style: textTheme.headline5.copyWith(
          color: widget.helper.color,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget get _buildLocation {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: AutoSizeText(
              '${widget.model.data.city.name}',
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 22,
                color: widget.helper.color,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'SHOWING NEAREST LOCATION',
            style: textTheme.subtitle2.copyWith(
              color: widget.helper.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildDate {
    AqiHelper helper = AqiHelper(widget.model);

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: AutoSizeText(
        dateFormat(widget.model.data.time.s),
        style: TextStyle(
          color: helper.color.withOpacity(0.85),
          fontSize: 20,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Stack get _buildStack {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        onBottom(AnimatedWave(
          height: widget.height * 0.65,
          speed: 1.0,
        )),
        Column(
          children: <Widget>[
            Spacer(),
            _buildAqiValue,
            _buildHealthTip,
            Spacer(),
            _buildLocation,
            _buildDate,
            Spacer(),
          ],
        ),
        onBottom(AnimatedWave(
          height: widget.height * 0.5,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: widget.height * 0.58,
          speed: 1.2,
          offset: pi / 2,
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AqiHelper helper = AqiHelper(widget.model);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          FadePageRoute(widget: DetailsScreen(model: widget.model)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(60),
          elevation: 20,
          shadowColor: Colors.black38,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              height: widget.height,
              width: widget.width,
              color: helper.backgroundColor,
              alignment: Alignment.bottomCenter,
              child: _buildStack,
            ),
          ),
        ),
      ),
    );
  }
}
