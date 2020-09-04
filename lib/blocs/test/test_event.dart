import 'dart:async';
import 'dart:developer' as developer;

import 'package:pureair/blocs/test/index.dart';
import 'package:meta/meta.dart';
import 'package:pureair/src/core/base_model.dart';
import 'package:pureair/src/core/dao.dart';
import 'package:pureair/src/core/server_error.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

Dao dao = Dao();

@immutable
abstract class TestEvent {
  Stream<TestState> applyAsync({TestState currentState, TestBloc bloc});
}

class UnTestEvent extends TestEvent {
  @override
  Stream<TestState> applyAsync({TestState currentState, TestBloc bloc}) async* {
    yield UnTestState();
  }
}

class LoadTestEvent extends TestEvent {
  @override
  Stream<TestState> applyAsync({TestState currentState, TestBloc bloc}) async* {
    final geos = [
      Geo(lat: 1.3666667, lon: 103.8),
      Geo(lat: 1.296183, lon: 103.846181),
      Geo(lat: 1.4296436, lon: 103.7960862),
      Geo(lat: 1.3645924, lon: 103.9477547),
      Geo(lat: 1.3880078, lon: 103.698064),
    ];
    try {
      yield UnTestState();
      await Future.delayed(Duration(seconds: 1));

      BaseModel<List<Aqi>> baseModel = await dao.getFavourites(geos);

      yield InTestState(baseModel.data);
    } catch (_) {
      BaseModel<List<Aqi>> baseModel = await dao.getFavourites(geos);
      ServerError error = baseModel.getException;
      yield ErrorTestState(error.getErrorMessage());
    }
  }
}
