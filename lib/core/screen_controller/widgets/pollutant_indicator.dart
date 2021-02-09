import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'pollutant_bar_indicator.dart';

class PollutantIndicator extends StatelessWidget {
  const PollutantIndicator({
    Key key,
    @required this.pollutantIndex,
    @required this.pollutantTitle,
  }) : super(key: key);

  final num pollutantIndex;
  final String pollutantTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final mainContainerHeight = size.height * 0.09;

    final domPolHeight = mainContainerHeight * 0.65;
    final domPolWidth = mainContainerHeight * 0.5;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: mainContainerHeight,
        width: mainContainerHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDomPol(domPolHeight, domPolWidth, theme),
            SizedBox(width: 12),
            _buildPollutionBarIndicator(size),
          ],
        ),
      ),
    );
  }

  Container _buildDomPol(double height, double width, ThemeData theme) {
    return Container(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDomPolValue(theme),
          SizedBox(height: 6),
          _buildDomPolName(theme),
        ],
      ),
    );
  }

  Widget _buildDomPolValue(ThemeData theme) {
    return AutoSizeText(
      '${pollutantIndex.toInt()}',
      minFontSize: 17,
      style: theme.textTheme.caption.copyWith(
        color: theme.colorScheme.onSecondary,
      ),
    );
  }

  Text _buildDomPolName(ThemeData theme) {
    return Text(
      pollutantTitle.toUpperCase(),
      style: theme.textTheme.caption.copyWith(
        color: theme.colorScheme.onSecondary,
        fontSize: 10,
      ),
    );
  }

  Widget _buildPollutionBarIndicator(Size size) {
    return PollutionBarIndicator(
      pollutantIndex: pollutantIndex.toInt(),
      height: size.height * 0.09,
      width: size.height * 0.09,
    );
  }
}
