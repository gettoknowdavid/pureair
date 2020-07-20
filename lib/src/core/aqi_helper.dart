import 'package:flutter/material.dart';
import 'package:pureair/src/model/aqi.dart';

class AqiHelper {
  final Aqi aqiModel;

  AqiHelper(this.aqiModel) : assert(aqiModel != null);

  static const green = const Color(0xFF1F8A51);
  static const yellow = const Color(0xFFFED714);
  static const orange = const Color(0xFFF9841F);
  static const red = const Color(0xFFB90027);
  static const purple = const Color(0xFF4F008A);
  static const maroon = const Color(0xFF67001B);

  Color get backgroundColor {
    Color color;
    var aqi = aqiModel.data.aqi;
    if (aqi < 51)
      color = green;
    else if (aqi < 101)
      color = yellow;
    else if (aqi < 151)
      color = orange;
    else if (aqi < 201)
      color = red;
    else if (aqi < 301)
      color = purple;
    else if (aqi < 501) color = maroon;
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

  Color get o3PollutantBgColor {
    Color color;
    var conc;
    if (aqiModel.data.iaqi.o3 == null) {
      return Color(0xFFF2F2F2);
    } else {
      conc = aqiModel.data.iaqi.o3.v;
      if (conc < 70)
        color = green;
      else if (conc < 125)
        color = yellow;
      else if (conc < 165)
        color = orange;
      else if (conc < 205)
        color = red;
      else if (conc < 405)
        color = purple;
      else if (conc < 504) color = maroon;
      return color;
    }
  }

  Color get o3TextColor {
    Color color = o3PollutantBgColor;
    int d = 0;
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0;
    else
      d = 229;
    return Color.fromARGB(color.alpha, d, d, d);
  }

  Color get coPollutantBgColor {
    Color color;
    var conc;
    if (aqiModel.data.iaqi.co == null) {
      return Color(0xFFF2F2F2);
    } else {
      conc = aqiModel.data.iaqi.co.v;
      if (conc < 4.5)
        color = green;
      else if (conc < 9.5)
        color = yellow;
      else if (conc < 12.5)
        color = orange;
      else if (conc < 15.5)
        color = red;
      else if (conc < 30.5)
        color = purple;
      else if (conc < 40.4) color = maroon;
      return color;
    }
  }

  Color get coTextColor {
    Color color = coPollutantBgColor;
    int d = 0;
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0;
    else
      d = 229;
    return Color.fromARGB(color.alpha, d, d, d);
  }

  Color get no2PollutantBgColor {
    Color color;
    var conc;
    if (aqiModel.data.iaqi.no2 == null) {
      return Color(0xFFF2F2F2);
    } else {
      conc = aqiModel.data.iaqi.no2.v;
      if (conc < 54)
        color = green;
      else if (conc < 101)
        color = yellow;
      else if (conc < 361)
        color = orange;
      else if (conc < 650)
        color = red;
      else if (conc < 1250)
        color = purple;
      else if (conc < 1649) color = maroon;
      return color;
    }
  }

  Color get no2TextColor {
    Color color = no2PollutantBgColor;
    int d = 0;
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0;
    else
      d = 229;
    return Color.fromARGB(color.alpha, d, d, d);
  }

  Color get pm10PollutantBgColor {
    Color color;
    var conc;
    if (aqiModel.data.iaqi.pm10 == null) {
      return Color(0xFFF2F2F2);
    } else {
      conc = aqiModel.data.iaqi.pm10.v;
      if (conc < 55)
        color = green;
      else if (conc < 155)
        color = yellow;
      else if (conc < 255)
        color = orange;
      else if (conc < 355)
        color = red;
      else if (conc < 425)
        color = purple;
      else if (conc < 504) color = maroon;
      return color;
    }
  }

  Color get pm10TextColor {
    Color color = pm10PollutantBgColor;
    int d = 0;
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0;
    else
      d = 229;
    return Color.fromARGB(color.alpha, d, d, d);
  }

  Color get pm25PollutantBgColor {
    Color color;
    var conc;
    if (aqiModel.data.iaqi.pm25 == null) {
      return Color(0xFFF2F2F2);
    } else {
      conc = aqiModel.data.iaqi.pm25.v;
      if (conc < 12.1)
        color = green;
      else if (conc < 35.5)
        color = yellow;
      else if (conc < 55.5)
        color = orange;
      else if (conc < 150.5)
        color = red;
      else if (conc < 250.5)
        color = purple;
      else if (conc < 350.4) color = maroon;
      return color;
    }
  }

  Color get pm25TextColor {
    Color color = pm25PollutantBgColor;
    int d = 0;
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0;
    else
      d = 229;
    return Color.fromARGB(color.alpha, d, d, d);
  }

  Color get so2PollutantBgColor {
    Color color;
    var conc;
    if (aqiModel.data.iaqi.so2 == null) {
      return Color(0xFFF2F2F2);
    } else {
      conc = aqiModel.data.iaqi.so2.v;
      if (conc < 36)
        color = green;
      else if (conc < 76)
        color = yellow;
      else if (conc < 186)
        color = orange;
      else if (conc < 305)
        color = red;
      else if (conc < 605)
        color = purple;
      else if (conc < 804) color = maroon;
      return color;
    }
  }

  Color get so2TextColor {
    Color color = so2PollutantBgColor;
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
              "Open your windows and breathe in the fresh air.",
        },
        {
          'images/icon-exercise.png': "Exercise? Yes you can!",
        },
        {
          'images/park.png':
              "You can enjoy outdoor activities to make you happy.",
        },
        {
          'images/heart.png':
              "The air is clean and fresh for babies and sensitive groups.",
        },
      ];
    } else if (aqi < 101) {
      tips = [
        {
          'images/icon-exercise.png': "Exercise? Yes you can!",
        },
        {
          'images/park.png':
              "You can enjoy outdoor activities to make you happy.",
        },
        {
          'images/heart.png':
              "Sensitive groups should reduce outdoor exercise.",
        },
        {
          'images/cycling.png': "Its a great time to go cycling.",
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
          'images/icon-avoid-exercise.png': "Avoid outdoor exercises",
        },
      ];
    }
    return tips;
  }
}
