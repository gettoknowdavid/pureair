import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/usecases/no_params.dart';
import '../../domain/usecases/update_aqi_by_condition_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/aqi_by_condition.dart';
import '../../domain/entities/condition_enum.dart';
import '../../domain/usecases/get_aqi_by_condition_usecase.dart';
import '../../domain/usecases/params/condition_params.dart';

part 'aqi_by_condition_event.dart';
part 'aqi_by_condition_state.dart';

class AqiByConditionBloc
    extends Bloc<AqiByConditionEvent, AqiByConditionState> {
  AqiByConditionBloc({
    @required this.getAqiUseCase,
    @required this.updateAqiUseCase,
  }) : super(AqiByConditionEmpty());

  final GetAqiByConditionUseCase getAqiUseCase;
  final UpdateAqiByConditionUseCase updateAqiUseCase;

  @override
  Stream<AqiByConditionState> mapEventToState(
    AqiByConditionEvent event,
  ) async* {
    if (event is GetAqiByCondition) {
      yield AqiByConditionLoading();

      final _result = await getAqiUseCase(NoParams());

      yield* _mapEitherToState(_result);
    } else if (event is UpdateAqiByCondition) {
      yield AqiByConditionLoading();

      final _result = await updateAqiUseCase(
        ConditionParams(condition: event.condition),
      );

      yield* _mapEitherToState(_result);
    }
  }

  Stream<AqiByConditionState> _mapEitherToState(
      Either<Failure, AqiByCondition> result) async* {
    yield result.fold(
      (failure) => AqiByConditionError(message: _mapFailureToMessage(failure)),
      (aqiByCondition) => AqiByConditionLoaded(aqiByCondition: aqiByCondition),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: Failed to fetch from server air quality.';
      case DatabaseFailure:
        return 'Database Error: Failed to load last air quality from store.';
      default:
        return 'Unexpected Error';
    }
  }
}
