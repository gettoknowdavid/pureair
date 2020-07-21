import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';

class SearchHelper {
  final int aqi;

  SearchHelper(this.aqi);

  Color get backgroundColor {
    Color color;
    if (aqi < 51)
      color = AqiHelper.green;
    else if (aqi < 101)
      color = AqiHelper.yellow;
    else if (aqi < 151)
      color = AqiHelper.orange;
    else if (aqi < 201)
      color = AqiHelper.red;
    else if (aqi < 301)
      color = AqiHelper.purple;
    else  color = AqiHelper.maroon;
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
}
