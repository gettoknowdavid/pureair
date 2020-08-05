import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/aqi.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  ModelBloc(this.repository) : super(ModelLoading());

  final Repository repository;

  Dao dao = Dao();
  DbRepository repo = DbRepository();

  @override
  Stream<ModelState> mapEventToState(
    ModelEvent event,
  ) async* {
    if (event is LoadModel) {
      yield* _mapLoadToState();
    } else if (event is RefreshModel) {
      yield* _mapRefreshToState();
    }
  }

  Stream<ModelState> _mapLoadToState() async* {
    try {
      Aqi model = await repository.loadModel;

      yield ModelLoaded(model);
    } catch (_) {
      yield ModelNotLoaded();
    }
  }

  Stream<ModelState> _mapRefreshToState() async* {
    yield ModelLoading();
    Aqi model = await repository.fetchModel;

    yield ModelLoaded(model);
    await repository.saveModel(model);
  }
}
