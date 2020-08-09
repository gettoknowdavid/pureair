import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/src/model/health_situation.dart';

class FavouritesHelper {
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

  List<String> tailoredMessage(SituationEnum situation, List<Aqi> models) {
    final doms = models.map((e) => e.data.dominentpol).toList();

    final List<String> _strings = [];

    switch (situation) {
      case SituationEnum.asthma:
        for (int i = 0; i > doms.length; i++) {
          _strings[i] = doms[i].contains('o3')
              ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
              : '';
        }
        return _strings;
      // return doms.map((e) => e.contains('o3')).toList() ||
      //        doms.where((e) => e.contains('pm10')).toList() ||
      //         doms.where((e) => e.contains('pm10')).toList()
      //     ? doms.forEach((element) {
      //         element =
      //             'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.';
      //       })
      //     : doms.forEach((element) {
      //         element = '';
      //       });

      case SituationEnum.bronchitis:
        for (int i = 0; i > doms.length; i++) {
          _strings[i] = doms[i].contains('o3')
              ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
              : '';
        }
        return _strings;

      case SituationEnum.emphysema:
        for (int i = 0; i > doms.length; i++) {
          _strings[i] = doms[i].contains('o3')
              ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
              : '';
        }
        return _strings;

      case SituationEnum.hbp:
        for (int i = 0; i > doms.length; i++) {
          _strings[i] = doms[i].contains('o3')
              ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
              : '';
        }
        return _strings;

      case SituationEnum.lungCancer:
        for (int i = 0; i > doms.length; i++) {
          _strings[i] = doms[i].contains('o3')
              ? 'Present air quality is dangerous for asthma. Stay indoors and close windows to protect yourself.'
              : '';
        }
        return _strings;
      default:
        return [];
    }

    // if(situation == SituationEnum.asthma) {
    //   if (o3 != null || pm25 != null || pm10 != null) {
    //     if (o3.v > 50 || )
    //   }
    // }
  }
}
