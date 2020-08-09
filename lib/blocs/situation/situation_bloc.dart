import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/blocs/situation_helper.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';

part 'situation_event.dart';
part 'situation_state.dart';

class SituationBloc extends Bloc<SituationEvent, SituationState> {
  SituationBloc(this.repository) : super(SituationLoading());

  final Repository repository;

  DbRepository repo = DbRepository();
  SituationHelper helper = SituationHelper();

  @override
  Stream<SituationState> mapEventToState(
    SituationEvent event,
  ) async* {
    if (event is LoadSituation) {
      try {
        HealthSituation healthSituation = await repo.loadSituation;

        print(healthSituation.situation);
        yield SituationLoaded(
          situation: healthSituation.situation,
          model: healthSituation.model,
          message: healthSituation.message,
          pollutants: healthSituation.pollutants,
        );
      } catch (_) {
        Aqi model = await repository.fetchModel;
        SituationEnum situation = SituationEnum.none;
        String message = helper.tailoredMessage(situation, model);
        List<Map<String, String>> pollutants =
            helper.pollutants(situation, model);
        yield SituationLoaded(
          situation: situation,
          model: model,
          message: message,
          pollutants: pollutants,
        );
      }
    } else if (event is UpdateSituation) {
      Aqi model = (state as SituationLoaded).model;
      String message = helper.tailoredMessage(event.situation, model);
      List<Map<String, String>> pollutants =
          helper.pollutants(event.situation, model);
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

      await repo.saveSituation(healthSituation);
    } else if (event is FetchModel) {
      Aqi model = await repository.fetchModel;
      SituationEnum situation = (state as SituationLoaded).situation;
      String message = helper.tailoredMessage(situation, model);
      List<Map<String, String>> pollutants =
          helper.pollutants(situation, model);
      yield SituationLoaded(
        situation: situation,
        model: model,
        message: message,
        pollutants: pollutants,
      );
    }
  }
}
