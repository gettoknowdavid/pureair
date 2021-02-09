import 'package:intl/intl.dart';

String dateFormatter(String dateTimeString) {
  var _dateTime = DateTime.parse(dateTimeString);

  String _weekDay = DateFormat('EEE').format(_dateTime);
  String _day = DateFormat('d').format(_dateTime);
  String _month = DateFormat('MMMM').format(_dateTime);
  String formattedDate = '$_weekDay' + '—' + '$_day' + ' $_month';

  return formattedDate;
}
