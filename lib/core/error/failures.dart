import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  Failure({this.properties = const <dynamic>[]});

  final List properties;

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {}

class DatabaseFailure extends Failure {}

class TimeoutFailure extends Failure {}
