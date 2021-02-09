import 'package:flutter/material.dart';
import 'detail_card.dart';

import '../../../../domain/entities/aqi.dart';
import '../../../widgets/more_info.dart';

class MoreInfoList extends StatelessWidget {
  const MoreInfoList({Key key, @required this.aqi}) : super(key: key);

  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    return _buildMoreInfoListCard();
  }

  Widget _buildMoreInfoListCard() {
    return DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('MORE INFO'),
          SizedBox(height: 20),
          MoreInfoWidget(
            title: 'Dominant Pollutant',
            value: aqi.data.dominentpol.toUpperCase(),
          ),
          Divider(),
          MoreInfoWidget(
            title: 'Station',
            value: aqi.data.attributions[0].name,
          ),
        ],
      ),
    );
  }
}
