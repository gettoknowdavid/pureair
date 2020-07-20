import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime _dateTime = DateTime.now();
String _weekDay = DateFormat('EEE').format(_dateTime);
String _day = DateFormat('d').format(_dateTime);
String _month = DateFormat('MMMM').format(_dateTime);
String formattedDate = '$_weekDay' + '—' + '$_day' + ' $_month';

String dateFormatter(DateTime dateTime, BuildContext context) {
  DateTime _dateTime = DateTime.now();
  String _weekDay = DateFormat('EEE').format(_dateTime);
  String _day = DateFormat('d').format(_dateTime);
  String _month = DateFormat('MMMM').format(_dateTime);
  String formattedDate = '$_weekDay' + '—' + '$_day' + ' $_month';
  TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);

  String finalDateTime = '$formattedDate at ${timeOfDay.format(context)}';
  return finalDateTime;
}
