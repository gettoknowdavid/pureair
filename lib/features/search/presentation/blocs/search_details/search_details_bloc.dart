import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../aqi/domain/entities/aqi_by_condition.dart';
import '../../../domain/usecases/get_search_details_usecase.dart';
import '../../../domain/usecases/parameters/details_params.dart';

part 'search_details_event.dart';
part 'search_details_state.dart';

class SearchDetailsBloc extends Bloc<SearchDetailsEvent, SearchDetailsState> {
  SearchDetailsBloc({
    @required this.getDetailsUseCase,
  }) : super(SearchDetailsEmpty());
  final GetSearchDetailsUseCase getDetailsUseCase;

  @override
  Stream<SearchDetailsState> mapEventToState(
    SearchDetailsEvent event,
  ) async* {
    if (event is GetSearchDetailsEvent) {
      yield SearchDetailsLoading();
      
      final _result = await getDetailsUseCase(
        DetailsParams(lat: event.lat, lon: event.lon),
      );

      yield* _mapEitherToState(_result);
    }
  }

  Stream<SearchDetailsState> _mapEitherToState(
      Either<Failure, AqiByCondition> result) async* {
    yield result.fold(
      (failure) => SearchDetailsError(message: _mapFailureToMessage(failure)),
      (result) => SearchDetailsLoaded(data: result),
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
