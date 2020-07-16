import 'package:flutter/material.dart';
import 'package:pureair/src/model/aqi.dart';

class AqiHelper {
  final Aqi aqiModel;

  AqiHelper(this.aqiModel) : assert(aqiModel != null);

  Color get backgroundColor {
    Color color;
    var aqi = aqiModel.data.aqi;
    if (aqi < 51)
      color = Color(0xFF1F8A51);
    else if (aqi < 101)
      color = Color(0xFFFED714);
    else if (aqi < 151)
      color = Color(0xFFF9841F);
    else if (aqi < 201)
      color = Color(0xFFB90027);
    else if (aqi < 301)
      color = Color(0xFF4F008A);
    else if (aqi < 501) color = Color(0xFF67001B);
    return color;
  }

  Color get color {
    Color color = backgroundColor;
    int d = 0;
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    if (luminance > 0.5)
      d = 0;
    else
      d = 229;
    return Color.fromARGB(color.alpha, d, d, d);
  }

  String get healthConcern {
    var aqi = aqiModel.data.aqi;
    String rec;
    if (aqi < 51) {
      rec = 'Great! Good air!';
    } else if (aqi < 101) {
      rec = 'Okay, the air is moderate.';
    } else if (aqi < 151) {
      rec = 'Oh, the air is unhealthy for sensitive groups.';
    } else if (aqi < 201) {
      rec = 'Ouch, the air is quite unhealthy.';
    } else if (aqi < 301) {
      rec = 'Wow, the air is very unhealthy!';
    } else if (aqi < 501) {
      rec = 'The air is hazardous! Totally unhealthy!';
    }
    return rec;
  }

  List<Map<String, String>> get healthRec {
    var aqi = aqiModel.data.aqi;
    List<Map<String, String>> tips;
    if (aqi < 51) {
      tips = [
        {
          'images/icon-window.png':
              "Open your windows and breathe in the fresh air",
        },
        {
          'images/icon-exercise.png':
              "You can enjoy outdoor activities and exercises to stay healthy",
        },
      ];
    } else if (aqi < 101) {
      tips = [
        {
          'images/icon-close-windows.png':
              "Close your windows to avoid dirty outdoor air",
        },
        {
          'images/icon-exercise.png':
              "Sensitive groups should reduce outdoor exercise",
        },
      ];
    } else if (aqi > 101) {
      tips = [
        {
          'images/icon-mask.png': "Wear a protection mask outdoors",
        },
        {
          'images/icon-close-windows.png':
              "Close your windows to avoid dirty outdoor air",
        },
        {
          'images/icon-avoid-exercise.png': "Avoid outdoor exercise",
        },
      ];
    }
    return tips;
  }
}
