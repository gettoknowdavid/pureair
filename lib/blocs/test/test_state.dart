import 'package:equatable/equatable.dart';
import 'package:pureair/src/model/aqi.dart';

abstract class TestState extends Equatable {
  final List propss;
  TestState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class UnTestState extends TestState {
  UnTestState();

  @override
  String toString() => 'UnTestState';
}

/// Initialized
class InTestState extends TestState {
  final List<Aqi> aqi;

  InTestState(this.aqi) : super([aqi]);

  @override
  String toString() => 'InTestState $aqi';
}

class ErrorTestState extends TestState {
  final String errorMessage;

  ErrorTestState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorTestState';
}
