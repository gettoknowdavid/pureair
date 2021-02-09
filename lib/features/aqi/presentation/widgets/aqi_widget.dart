import 'package:flutter/material.dart';

import '../../../../core/widgets/fade_page_route.dart';
import '../../domain/entities/aqi_by_condition.dart';
import '../screens/details/details_screen.dart';
import 'animated_wave.dart';
import 'aqi_index_widget.dart';
import 'aqi_screen_condition_widget.dart';
import 'brief_details_widget.dart';

class AqiWidget extends StatelessWidget {
  const AqiWidget({Key key, @required this.aqiByCondition}) : super(key: key);
  final AqiByCondition aqiByCondition;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final aqi = aqiByCondition.aqi;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Stack(
        children: [
          buildWave(AnimatedWave(height: height * .6, speed: 1, offset: 90)),
          buildWave(AnimatedWave(height: height * .65, speed: .7)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AqiIndexWidget(aqi: aqi),
              BriefDetailsWidget(
                aqi: aqi,
                onTap: () => _navigateToDetails(context, aqiByCondition),
              ),
              SizedBox(height: 10),
              AqiScreenConditionWidget(aqiByCondition: aqiByCondition),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  _navigateToDetails(BuildContext context, AqiByCondition aqiByCondition) {
    Navigator.of(context).push(
      FadePageRoute(
        widget: DetailsScreen(aqiByCondition: aqiByCondition),
      ),
    );
  }
}
