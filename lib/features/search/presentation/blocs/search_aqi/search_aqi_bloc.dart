import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/search_aqi.dart';
import '../../../domain/usecases/parameters/search_city_params.dart';
import '../../../domain/usecases/search_city_usecase.dart';

part 'search_aqi_event.dart';
part 'search_aqi_state.dart';

class SearchAqiBloc extends Bloc<SearchAqiEvent, SearchAqiState> {
  SearchAqiBloc({
    @required this.searchCityUseCase,
  }) : super(SearchAqiEmpty());

  final SearchCityUseCase searchCityUseCase;

  @override
  Stream<SearchAqiState> mapEventToState(
    SearchAqiEvent event,
  ) async* {
    if (event is SearchCityEvent) {
      yield SearchAqiLoading();
      
      final _result = await searchCityUseCase(SearchParams(city: event.city));

      yield* _mapEitherToState(_result);
    }
  }

  Stream<SearchAqiState> _mapEitherToState(
      Either<Failure, SearchAqi> result) async* {
    yield result.fold(
      (failure) => SearchAqiError(message: _mapFailureToMessage(failure)),
      (searchAqi) => SearchAqiLoaded(searchAqi: searchAqi),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: Failed to search for city from server air quality.';
      default:
        return 'Unexpected Error';
    }
  }
}
