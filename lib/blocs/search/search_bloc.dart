import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(SearchCleared());

  final Repository repository;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchCity) {
      yield SearchLoading();
      try {
        final searchAqi = await repository.searchModel(event.city);

        yield SearchLoaded(searchAqi);
      } catch (_) {
        yield SearchNotLoaded();
      }
    } else if (event is ClearSearch) {
      yield SearchCleared();
    }
  }
}
