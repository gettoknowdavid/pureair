import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/search_model/search.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:pureair/src/model/search_model/search_data.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(SearchResult([]));

  final Repository repository;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is LoadStationData) {
      yield* _mapLoadStationDataToState();
    } else if (event is FetchSearch) {
      yield* _mapFecthSearchToState(event);
    } else if (event is AddStation) {
      yield* _mapAddStationToState(event);
    }
  }

  // Stream<SearchState> _mapLoadSearchToState() async* {
  //   yield SearchLoading();
  //   try {
  //     Search search = await repository.loadSearchModel;
  //     yield SearchResult(search.stations);
  //   } catch (_) {
  //     yield SearchNotLoaded();
  //   }
  // }

  Stream<SearchState> _mapLoadStationDataToState() async* {
    Search search = await repository.loadSearchModel;
    yield StoredStations(search.stations);
  }

  Stream<SearchState> _mapFecthSearchToState(FetchSearch event) async* {
    SearchAqi searchedCity = await repository.searchModel(event.city);

    yield StoredStations(searchedCity.data);
  }

  Future<List<SearchData>> _getStations(String city) async {
    SearchAqi searchedCity = await repository.searchModel(city);
    final _list = list..addAll(searchedCity.data);
    return _list;
  }

  List<SearchData> list = [];

  Stream<SearchState> _mapAddStationToState(AddStation event) async* {
    if (state is SearchResult) {
      list..add(event.data);

      yield StoredStations(list);

      Search search = Search(stations: list);
      await repository.saveSearchModel(search);
    }
  }
}
