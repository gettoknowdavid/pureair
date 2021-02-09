import 'package:flutter/material.dart';

import '../../../../../../core/screen_controller/widgets/pollutant_indicator.dart';
import '../../../../domain/entities/aqi.dart';
import 'detail_card.dart';

class PollutantsGrid extends StatelessWidget {
  const PollutantsGrid({Key key, @required this.aqi}) : super(key: key);

  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    var co = aqi.data.iaqi.co == null ? 0 : aqi.data.iaqi.co.v;
    var pm10 = aqi.data.iaqi.pm10 == null ? 0 : aqi.data.iaqi.pm10.v;
    var pm25 = aqi.data.iaqi.pm25 == null ? 0 : aqi.data.iaqi.pm25.v;
    var no2 = aqi.data.iaqi.no2 == null ? 0 : aqi.data.iaqi.no2.v;
    var so2 = aqi.data.iaqi.so2 == null ? 0 : aqi.data.iaqi.so2.v;
    var o3 = aqi.data.iaqi.o3 == null ? 0 : aqi.data.iaqi.o3.v;

    List<PollutantIndicator> _pollutants = <PollutantIndicator>[
      PollutantIndicator(pollutantIndex: co, pollutantTitle: 'CO'),
      PollutantIndicator(pollutantIndex: pm10, pollutantTitle: 'PM10'),
      PollutantIndicator(pollutantIndex: pm25, pollutantTitle: 'PM2.5'),
      PollutantIndicator(pollutantIndex: no2, pollutantTitle: 'NO\u2082'),
      PollutantIndicator(pollutantIndex: so2, pollutantTitle: 'SO\u2082'),
      PollutantIndicator(pollutantIndex: o3, pollutantTitle: 'O\u2083'),
    ];

    return DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('POLLUTANTS'),
          SizedBox(height: 10),
          GridView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 25,
            ),
            children: _pollutants,
          )
        ],
      ),
    );
  }
}
