import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/blocs/situation/situation_bloc.dart';
import 'package:pureair/blocs/situation_helper.dart';
import 'package:pureair/src/core/base_model.dart';
import 'package:pureair/src/core/dao.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';

part 'search_details_event.dart';
part 'search_details_state.dart';

class SearchDetailsBloc extends Bloc<SearchDetailsEvent, SearchDetailsState> {
  SearchDetailsBloc(this.situationBloc) : super(SearchDetailsLoading()) {
    situationSubscription = situationBloc.listen((state) {
      if (state is SituationLoaded) {
        UpdateModel((situationBloc.state as SituationLoaded).situation);
      }
    });
  }

  Dao dao = Dao();
  SituationHelper helper = SituationHelper();

  final SituationBloc situationBloc;
  StreamSubscription situationSubscription;

  @override
  Stream<SearchDetailsState> mapEventToState(
    SearchDetailsEvent event,
  ) async* {
    if (event is FetchSearchDetails) {
      yield SearchDetailsLoading();
      try {
        BaseModel<Aqi> baseModel = await dao.getSearchDetails(event.lat, event.lon);
        SituationEnum situation =
            (situationBloc.state as SituationLoaded).situation;
        String message = helper.tailoredMessage(situation, baseModel.data);
        List<Map<String, String>> pollutants =
            helper.pollutants(situation, baseModel.data);

        yield SearchDetailsLoaded(baseModel.data, situation, message, pollutants);
      } catch (_) {
        yield SearchDetailsNotLoaded();
      }
    } else if (event is UpdateModel) {
      if (situationBloc.state is SituationLoaded) {
        Aqi model = (state as SearchDetailsLoaded).model;
        SituationEnum situation =
            (situationBloc.state as SituationLoaded).situation;
        String message = helper.tailoredMessage(situation, model);
        List<Map<String, String>> pollutants =
            helper.pollutants(situation, model);

        yield SearchDetailsLoaded(model, situation, message, pollutants);
      }
    } else if (event is ClearSearchDetails) {
      yield SearchDetailsLoading();
    }
  }

  @override
  Future<void> close() {
    situationSubscription.cancel();
    return super.close();
  }
}
