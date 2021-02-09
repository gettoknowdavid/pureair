part of 'aqi_by_condition_bloc.dart';

abstract class AqiByConditionState extends Equatable {
  const AqiByConditionState();

  @override
  List<Object> get props => [];
}

class AqiByConditionEmpty extends AqiByConditionState {}

class AqiByConditionLoading extends AqiByConditionState {}

class AqiByConditionLoaded extends AqiByConditionState {
  AqiByConditionLoaded({@required this.aqiByCondition});

  final AqiByCondition aqiByCondition;

  @override
  List<Object> get props => [aqiByCondition];
}

class AqiByConditionError extends AqiByConditionState {
  AqiByConditionError({@required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
