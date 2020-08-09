import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/src/model/health_situation.dart';

class SituationHelper {

  Favourites flagged(Favourites favourites, SituationEnum situation) {
    if (situation == SituationEnum.asthma) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol == 'o3' ||
              e.data.dominentpol == 'pm25' ||
              e.data.dominentpol == 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.bronchitis) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol == 'no2' ||
              e.data.dominentpol == 'pm25' ||
              e.data.dominentpol == 'pm10')
          .toList();
      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.emphysema) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol == 'o3' ||
              e.data.dominentpol == 'no2' ||
              e.data.dominentpol == 'pm25' ||
              e.data.dominentpol == 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.lungCancer) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol == 'o3' ||
              e.data.dominentpol == 'no2' ||
              e.data.dominentpol == 'so2' ||
              e.data.dominentpol == 'pm25' ||
              e.data.dominentpol == 'pm10')
          .toList();
      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.hbp) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol == 'o3' ||
              e.data.dominentpol == 'pm25' ||
              e.data.dominentpol == 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else {
      List<Aqi> models = favourites.favModels.toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    }
  }

  Favourites safe(Favourites favourites, SituationEnum situation) {
    if (situation == SituationEnum.asthma) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol != 'o3' ||
              e.data.dominentpol != 'pm25' ||
              e.data.dominentpol != 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.bronchitis) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol != 'no2' ||
              e.data.dominentpol != 'pm25' ||
              e.data.dominentpol != 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.emphysema) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol != 'o3' ||
              e.data.dominentpol != 'no2' ||
              e.data.dominentpol != 'pm25' ||
              e.data.dominentpol != 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.lungCancer) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol != 'o3' ||
              e.data.dominentpol != 'no2' ||
              e.data.dominentpol != 'so2' ||
              e.data.dominentpol != 'pm25' ||
              e.data.dominentpol != 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else if (situation == SituationEnum.hbp) {
      List<Aqi> models = favourites.favModels
          .where((e) =>
              e.data.dominentpol != 'pm25' || e.data.dominentpol != 'pm10')
          .toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    } else {
      List<Aqi> models = favourites.favModels.toList();

      List<Geo> geos = favourites.geos
          .where((e) =>
              models.map((e) => e.data.city.geo[0]).contains(e.lat) &&
              models.map((e) => e.data.city.geo[1]).contains(e.lon))
          .toList();
      return Favourites(geos: geos, favModels: models);
    }
  }

  List<Map<String, String>> pollutants(SituationEnum situation, Aqi model) {
    final iaqi = model.data.iaqi;
    // final co = iaqi.co;
    final o3Value = iaqi.o3 != null ? '${iaqi.o3.v.round()}' : '-';
    final no2Value = iaqi.no2 != null ? '${iaqi.no2.v.round()}' : '-';
    final so2Value = iaqi.so2 != null ? '${iaqi.so2.v.round()}' : '-';
    final pm10Value = iaqi.pm10 != null ? '${iaqi.pm10.v.round()}' : '-';
    final pm25Value = iaqi.pm25 != null ? '${iaqi.pm25.v.round()}' : '-';

    switch (situation) {
      case SituationEnum.asthma:
        return [
          {'o3': o3Value},
          {'pm10': pm10Value},
          {'pm25': pm25Value}
        ];
      case SituationEnum.bronchitis:
        return [
          {'no2': no2Value},
          {'pm10': pm10Value},
          {'pm25': pm25Value}
        ];
      case SituationEnum.lungCancer:
        return [
          {'o3': o3Value},
          {'so2': so2Value},
          {'no2': no2Value},
          {'pm10': pm10Value},
          {'pm25': pm25Value}
        ];
      case SituationEnum.emphysema:
        return [
          {'o3': o3Value},
          {'no2': no2Value},
          {'pm10': pm10Value},
          {'pm25': pm25Value}
        ];
      case SituationEnum.hbp:
        return [
          {'o3': o3Value},
          {'pm10': pm10Value},
          {'pm25': pm25Value}
        ];
      default:
        return [];
    }
  }

  String tailoredMessage(SituationEnum situation, Aqi model) {
    final dom = model.data.dominentpol;

    switch (situation) {
      case SituationEnum.asthma:
        return dom.contains('o3') ||
                dom.contains('pm25') ||
                dom.contains('pm10')
            ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
            : '';

      case SituationEnum.bronchitis:
        return dom.contains('no2') ||
                dom.contains('pm25') ||
                dom.contains('pm10')
            ? 'If you have bronchitis, this air is unhealthy for you. Please wear a nose mask and reduce your outdoor exercises to protect yourself from the bad air.'
            : '';

      case SituationEnum.emphysema:
        return dom.contains('o3') ||
                dom.contains('no2') ||
                dom.contains('pm25') ||
                dom.contains('pm10')
            ? 'Pollutants present in the air may worsen emphysema. Please wear a nose mask to protect yourself from the bad air.'
            : '';

      case SituationEnum.hbp:
        return dom.contains('o3') ||
                dom.contains('pm25') ||
                dom.contains('pm10')
            ? 'Present conditions may increase your blood pressure. Please wear a nose mask to protect yourself from the bad air.'
            : '';

      case SituationEnum.lungCancer:
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

    // if(situation == SituationEnum.asthma) {
    //   if (o3 != null || pm25 != null || pm10 != null) {
    //     if (o3.v > 50 || )
    //   }
    // }
  }
}
