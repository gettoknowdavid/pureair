import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/pureair.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  ModelBloc(this.repository) : super(ModelLoading());

  final Repository repository;

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
      PureAir pureAir = await repository.loadPureAir;

      yield ModelLoaded(pureAir);
    } catch (_) {
      yield ModelNotLoaded();
    }
  }

  Stream<ModelState> _mapRefreshToState() async* {
    try {
      Aqi model = await repository.fetchModel;
      PureAir pureAir = PureAir(model: model);

      yield ModelLoaded(pureAir);
      await repository.savePureAir(pureAir);
    } catch (_) {
      yield ModelNotLoaded();
    }
  }
}
