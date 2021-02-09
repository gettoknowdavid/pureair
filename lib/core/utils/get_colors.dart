import 'package:flutter/material.dart';

import 'aqi_colors.dart';

Color getBackgroundColor(int index) {
  Color color;

  if (index < 51) {
    color = green;
  } else if (index < 101) {
    color = yellow;
  } else if (index < 151) {
    color = orange;
  } else if (index < 201) {
    color = red;
  } else if (index < 301) {
    color = purple;
  } else {
    color = maroon;
  }
  return color;
}

Color getTextColor(int index) {
  var color = getBackgroundColor(index);
  var d = 0;
  var luminance =
      (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

  if (luminance > 0.5) {
    d = 0;
  } else {
    d = 229;
  }
  return Color.fromARGB(color.alpha, d, d, d);
}
