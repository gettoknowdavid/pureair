import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/model/aqi.dart';

part 'search_details_event.dart';
part 'search_details_state.dart';

class SearchDetailsBloc extends Bloc<SearchDetailsEvent, SearchDetailsState> {
  SearchDetailsBloc() : super(SearchDetailsLoading());

  Dao dao = Dao();

  @override
  Stream<SearchDetailsState> mapEventToState(
    SearchDetailsEvent event,
  ) async* {
    if (event is FetchSearchDetails) {
      yield SearchDetailsLoading();
      try {
        Aqi model = await dao.fetchSearchDetails(event.lat, event.lon);
        yield SearchDetailsLoaded(model);
      } catch (_) {
        yield SearchDetailsNotLoaded();
      }
    } else if (event is ClearSearchDetails) {
      yield SearchDetailsLoading();
    }
  }
}
