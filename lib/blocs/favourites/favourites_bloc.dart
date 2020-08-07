import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/geo.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesLoading());

  Dao dao = Dao();
  DbRepository repo = DbRepository();

  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    if (event is LoadFavourites) {
      try {
        Favourites favourites = await repo.loadFavourites;

        yield FavouritesLoaded(favourites);
      } catch (_) {
        yield FavouritesLoaded(Favourites(geos: [], favModels: []));
      }
    } else if (event is RefreshFavourites) {
      try {
        // yield FavouritesLoading();
        Favourites f = await repo.loadFavourites;
        List<Geo> geos = f.geos.toList();

        List<Aqi> favModels = await dao.fetchFavs(geos);

        Favourites favourites = Favourites(geos: geos, favModels: favModels);
        yield FavouritesLoaded(favourites);
        await repo.saveFavourites(favourites);
      } catch (_) {
        yield FavouritesNotLoaded();
      }
    } else if (event is AddFavourite) {
      if (state is FavouritesLoaded) {
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
          yield FavouritesLoaded(favourites);
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
      if (state is FavouritesLoaded) {
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
        yield FavouritesLoaded(favourites);
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
      }
    }
  }
}
