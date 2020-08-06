import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pureair/blocs/favourites/favourites_bloc.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/src/model/situation.dart';

part 'situation_event.dart';
part 'situation_state.dart';

class SituationBloc extends Bloc<SituationEvent, SituationState> {
  SituationBloc({
    @required this.favouritesBloc,
  }) : super(
          favouritesBloc.state is FavouritesLoaded
              ? SituationLoaded(
                  SituationEnum.none,
                  (favouritesBloc.state as FavouritesLoaded).favourites,
                )
              : SituationLoading(),
        ) {
    favouritesSubscription = favouritesBloc.listen((state) {
      if (state is FavouritesLoaded) {
        add(
          UpdateFavourites(
            (favouritesBloc.state as FavouritesLoaded).favourites,
          ),
        );
      }
    });
  }

  final FavouritesBloc favouritesBloc;
  StreamSubscription favouritesSubscription;

  @override
  Stream<SituationState> mapEventToState(
    SituationEvent event,
  ) async* {
    if (event is UpdateSituation) {
      if (favouritesBloc.state is FavouritesLoaded) {
        yield SituationLoaded(
          event.situation,
          _aqiBasedOnSituation(
            (favouritesBloc.state as FavouritesLoaded).favourites,
            event.situation,
          ),
        );
      }
    } else if (event is UpdateFavourites) {
      final situation = state is SituationLoaded
          ? (state as SituationLoaded).situation
          : SituationEnum.none;
      yield SituationLoaded(
        situation,
        _aqiBasedOnSituation(
          (favouritesBloc.state as FavouritesLoaded).favourites,
          situation,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    favouritesSubscription.cancel();
    return super.close();
  }

  Favourites _aqiBasedOnSituation(
      Favourites favourites, SituationEnum situation) {
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
              e.data.dominentpol == 'pm25' || e.data.dominentpol == 'pm10')
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
}
