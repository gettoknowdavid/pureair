
import '../../features/aqi/domain/entities/aqi.dart';
import '../../features/aqi/domain/entities/condition_enum.dart';

List<Map<String, String>> getPollutants(Aqi aqi, ConditionEnum condition) {
  final iaqi = aqi.data.iaqi;
  final o3 = iaqi.o3 != null ? '${iaqi.o3.v.round()}' : '-';
  final no2 = iaqi.no2 != null ? '${iaqi.no2.v.round()}' : '-';
  final so2 = iaqi.so2 != null ? '${iaqi.so2.v.round()}' : '-';
  final pm10 = iaqi.pm10 != null ? '${iaqi.pm10.v.round()}' : '-';
  final pm25 = iaqi.pm25 != null ? '${iaqi.pm25.v.round()}' : '-';

  switch (condition) {
    case ConditionEnum.asthma:
      return [
        {'o3': o3},
        {'pm10': pm10},
        {'pm25': pm25}
      ];
    case ConditionEnum.bronchitis:
      return [
        {'no2': no2},
        {'pm10': pm10},
        {'pm25': pm25}
      ];
    case ConditionEnum.lungCancer:
      return [
        {'o3': o3},
        {'so2': so2},
        {'no2': no2},
        {'pm10': pm10},
        {'pm25': pm25}
      ];
    case ConditionEnum.emphysema:
      return [
        {'o3': o3},
        {'no2': no2},
        {'pm10': pm10},
        {'pm25': pm25}
      ];
    case ConditionEnum.hbp:
      return [
        {'o3': o3},
        {'pm10': pm10},
        {'pm25': pm25}
      ];
    default:
      return [];
  }
}
