import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/aqi_converter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/aqi.dart';

class AqiDateWidget extends StatelessWidget {
  const AqiDateWidget({Key key, @required this.aqi}) : super(key: key);
  final Aqi aqi;

  @override
  Widget build(BuildContext context) {
    final converter = AqiConverter(aqi: aqi);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: AutoSizeText(
          dateFormatter(aqi.data.time.iso),
          style: TextStyle(
            color: converter.textColor.withOpacity(0.85),
            fontSize: 20,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
