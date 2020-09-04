import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:pureair/blocs/test/index.dart';

class TestBloc extends Bloc<TestEvent, TestState> {

  TestBloc(TestState initialState) : super(initialState);

  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'TestBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
