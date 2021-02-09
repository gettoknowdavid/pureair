import 'aqi_level.dart';

String getHealthRecs(AqiLevel level) {
  switch (level) {
    case AqiLevel.Good:
      return 'You can open you windows to breathe in the fresh air, do some exercise and enjoy your time outdoors.';
    case AqiLevel.Moderate:
      return 'You can still enjoy outdoor activities, but sensitive groups should reduce outdoor exercises.';
    case AqiLevel.UnForSenGroups:
      return 'Outdoor activities should be reduced, nose masks should be worn when going out and sensitive groups should stay in doors.';
    default:
      return 'All groups should avoid outdoor exercises, close windows and sensitive groups should stay in doors.';
  }
}
