import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({
    Key key,
    @required this.model,
    @required this.size,
  }) : super(key: key);

  final Aqi model;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final helper = AqiHelper(model);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: helper.healthRec.map(
        (e) {
          return Container(
            height: size.shortestSide * 0.16,
            width: size.shortestSide * 0.16,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ImageIcon(
              AssetImage(e.keys.elementAt(0)),
              color: helper.backgroundColor,
            ),
          );
        },
      ).toList(),
    );
  }
}