import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:pureair/src/model/search_model/search_data.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(SearchLoading());

  final Repository repository;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchCity) {
      try {
        final searchAqi = await repository.searchModel(event.city);
        yield SearchLoaded(searchAqi);
      } catch (_) {
        yield SearchNotLoaded();
      }
    } else if (event is ClearSearch) {
      yield SearchLoading();
    }
  }

  // Future<SearchData> _getRecentValues(String city, int uid) async {
  //   final SearchAqi search = await repository.searchModel(city);

  //   final SearchData s =
  //       search.data.firstWhere((element) => element.uid == uid);
  //   print(s);
  //   return s;
  // }
}
