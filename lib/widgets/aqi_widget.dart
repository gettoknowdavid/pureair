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
    this.height,
    this.helper,
  }) : super(key: key);
  @override
  _AqiWidgetState createState() => _AqiWidgetState();
}

class _AqiWidgetState extends State<AqiWidget> {
  Size get size => MediaQuery.of(context).size;

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

  Widget get _buildDetailsButton {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: MaterialButton(
        color: widget.helper.color.withOpacity(0.9),
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        onPressed: () {
          Navigator.of(context).push(
            FadePageRoute(
              widget: DetailsScreen(model: widget.model),
            ),
          );
        },
        child: Text(
          'MORE',
          style: textTheme.bodyText1.copyWith(
            letterSpacing: 3,
            color: widget.helper.backgroundColor,
          ),
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
          height: size.height * 0.65,
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
            SizedBox(height: 50),
            _buildDetailsButton,
          ],
        ),
        onBottom(AnimatedWave(
          height: size.height * 0.5,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: size.height * 0.58,
          speed: 1.2,
          offset: pi / 2,
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AqiHelper helper = AqiHelper(widget.model);

    return Container(
      width: widget.width,
      color: helper.backgroundColor,
      alignment: Alignment.bottomCenter,
      child: _buildStack,
    );
  }
}
