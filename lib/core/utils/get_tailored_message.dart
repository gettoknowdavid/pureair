import '../../features/aqi/domain/entities/aqi.dart';
import '../../features/aqi/domain/entities/condition_enum.dart';

String getTailoredMessage(Aqi aqi, ConditionEnum condition) {
  final dom = aqi.data.dominentpol;

  switch (condition) {
    case ConditionEnum.asthma:
      return dom.contains('o3') || dom.contains('pm25') || dom.contains('pm10')
          ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
          : '';
    case ConditionEnum.emphysema:
      return dom.contains('o3') ||
              dom.contains('no2') ||
              dom.contains('pm25') ||
              dom.contains('pm10')
          ? 'Pollutants present in the air may worsen emphysema. Please wear a nose mask to protect yourself from the bad air.'
          : '';
    case ConditionEnum.bronchitis:
      return dom.contains('no2') || dom.contains('pm25') || dom.contains('pm10')
          ? 'If you have bronchitis, this air is unhealthy for you. Please wear a nose mask and reduce your outdoor exercises to protect yourself from the bad air.'
          : '';
    case ConditionEnum.hbp:
      return dom.contains('o3') || dom.contains('pm25') || dom.contains('pm10')
          ? 'Present conditions may increase your blood pressure. Please wear a nose mask to protect yourself from the bad air.'
          : '';
    case ConditionEnum.lungCancer:
      return dom.contains('so2') ||
              dom.contains('o3') ||
              dom.contains('no2') ||
              dom.contains('pm25') ||
              dom.contains('pm10')
          ? 'May lead to lung cancer. Please wear a nose mask to protect yourself from the bad air.'
          : '';
    default:
      return '';
  }
}
