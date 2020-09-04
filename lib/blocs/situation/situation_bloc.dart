import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/blocs/situation_helper.dart';
import 'package:pureair/src/core/base_model.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';

part 'situation_event.dart';
part 'situation_state.dart';

class SituationBloc extends Bloc<SituationEvent, SituationState> {
  SituationBloc(this.repository) : super(SituationLoading());

  final Repository repository;

  SituationHelper helper = SituationHelper();

  Stream<SituationState> _mapLoadSituation() async* {
    try {
      HealthSituation healthSituation = await repository.loadSituation;

      yield SituationLoaded(
        situation: healthSituation.situation,
        model: healthSituation.model,
        message: healthSituation.message,
        pollutants: healthSituation.pollutants,
      );
    } catch (_) {
      BaseModel<Aqi> baseModel = await repository.fetchModel;

      SituationEnum situation = SituationEnum.none;
      String message = helper.tailoredMessage(situation, baseModel.data);
      final pollutants = helper.pollutants(situation, baseModel.data);

      yield SituationLoaded(
        situation: situation,
        model: baseModel.data,
        message: message,
        pollutants: pollutants,
      );
    }
  }

  Stream<SituationState> _mapUpdateSituation(UpdateSituation event) async* {
    Aqi model = (state as SituationLoaded).model;
    String message = helper.tailoredMessage(event.situation, model);
    final pollutants = helper.pollutants(event.situation, model);
    HealthSituation healthSituation = HealthSituation(
      situation: event.situation,
      model: model,
      message: message,
      pollutants: pollutants,
    );
    yield SituationLoaded(
      situation: event.situation,
      model: model,
      message: message,
      pollutants: pollutants,
    );

    await repository.saveSituation(healthSituation);
  }

  Stream<SituationState> _mapFetchModel() async* {
    BaseModel<Aqi> baseModel = await repository.fetchModel;

    SituationEnum situation = (state as SituationLoaded).situation;
    String message = helper.tailoredMessage(situation, baseModel.data);
    final pollutants = helper.pollutants(situation, baseModel.data);

    yield SituationLoaded(
      situation: situation,
      model: baseModel.data,
      message: message,
      pollutants: pollutants,
    );
  }

  @override
  Stream<SituationState> mapEventToState(
    SituationEvent event,
  ) async* {
    if (event is LoadSituation) {
      yield* _mapLoadSituation();
    } else if (event is UpdateSituation) {
      yield* _mapUpdateSituation(event);
    } else if (event is FetchModel) {
      yield* _mapFetchModel();
    }
  }
}
