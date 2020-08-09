import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pureair/blocs/situation/situation_bloc.dart';
import 'package:pureair/blocs/situation_helper.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/src/model/health_situation.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc(this.situationBloc)
      : super(
          situationBloc.state is SituationLoaded
              ? FavouritesLoaded(
                  Favourites(geos: [], favModels: []),
                  (situationBloc.state as SituationLoaded).situation,
                )
              : FavouritesLoading(),
        ) {
    situationSubscription = situationBloc.listen((state) {
      if (state is SituationLoaded) {
        add(UpdateModel((situationBloc.state as SituationLoaded).situation));
      }
    });
  }

  final SituationBloc situationBloc;
  StreamSubscription situationSubscription;

  Dao dao = Dao();
  DbRepository repo = DbRepository();
  SituationHelper helper = SituationHelper();

  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    if (event is LoadFavourites) {
      try {
        if (situationBloc.state is SituationLoaded) {
          Favourites favourites = await repo.loadFavourites;
          SituationEnum situation =
              (situationBloc.state as SituationLoaded).situation;

          yield FavouritesLoaded(favourites, situation);
        }
      } catch (_) {
        yield FavouritesNotLoaded();
      }
    } else if (event is RefreshFavourites) {
      // yield FavouritesLoading();
      if (situationBloc.state is SituationLoaded) {
        yield FavouritesLoading();

        try {
          Favourites f = await repo.loadFavourites;
          List<Geo> geos = f.geos.toList();

          List<Aqi> favModels = await dao.fetchFavs(geos);

          Favourites favourites = Favourites(geos: geos, favModels: favModels);
          SituationEnum situation =
              (situationBloc.state as SituationLoaded).situation;

          yield FavouritesLoaded(favourites, situation);
          await repo.saveFavourites(favourites);
        } catch (_) {
          SituationEnum situation =
              (situationBloc.state as SituationLoaded).situation;
          Favourites favourites = (state as FavouritesLoaded).favourites;

          yield FavouritesLoaded(favourites, situation);
        }
      }
    } else if (event is AddFavourite) {
      if (situationBloc.state is SituationLoaded) {
        if ((state as FavouritesLoaded).favourites.geos.contains(event.geo) ||
            (state as FavouritesLoaded)
                .favourites
                .favModels
                .map((e) => e.data.city.geo)
                .toList()
                .contains(event.geo)) {
          event.key.currentState.showSnackBar(
            SnackBar(
              content: Container(
                height: 30,
                child: Center(
                  child: Text('Already added'),
                ),
              ),
            ),
          );
        } else {
          List<Geo> geos =
              List<Geo>.from((state as FavouritesLoaded).favourites.geos)
                ..add(event.geo);

          Aqi favModel =
              await dao.fetchSearchDetails(event.geo.lat, event.geo.lon);
          List<Aqi> favModels =
              List<Aqi>.from((state as FavouritesLoaded).favourites.favModels)
                ..add(favModel);

          Favourites favourites = Favourites(geos: geos, favModels: favModels);
          SituationEnum situation =
              (situationBloc.state as SituationLoaded).situation;

          yield FavouritesLoaded(favourites, situation);
          await repo.saveFavourites(favourites);
          event.key.currentState.showSnackBar(
            SnackBar(
              content: Container(
                height: 30,
                child: Center(
                  child: Text('Location added'),
                ),
              ),
            ),
          );
        }
      }
    } else if (event is RemoveFavourite) {
      if (situationBloc.state is SituationLoaded) {
        print("SituationLoaded");
        List<Geo> geos = (state as FavouritesLoaded)
            .favourites
            .geos
            .where((element) =>
                element.lat != event.geo.lat && element.lon != event.geo.lon)
            .toList();

        List<Aqi> favModels = (state as FavouritesLoaded)
            .favourites
            .favModels
            .where((element) => element.data.idx != event.idx)
            .toList();

        Favourites favourites = Favourites(geos: geos, favModels: favModels);
        SituationEnum situation =
            (situationBloc.state as SituationLoaded).situation;

        yield FavouritesLoaded(favourites, situation);
        event.key.currentState.showSnackBar(
          SnackBar(
            content: Container(
              height: 30,
              child: Center(
                child: Text('Location removed'),
              ),
            ),
          ),
        );
        await repo.saveFavourites(favourites);
      } else {
        print("SituationNotLoaded");
      }
    } else if (event is UpdateModel) {
      SituationEnum situation = event.situation;
      Favourites favourites = (state as FavouritesLoaded).favourites;

      yield FavouritesLoaded(favourites, situation);
    }
  }

  @override
  Future<void> close() {
    situationSubscription.cancel();
    return super.close();
  }
}
