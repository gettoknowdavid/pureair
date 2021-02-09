part of 'aqi_by_condition_bloc.dart';

abstract class AqiByConditionEvent extends Equatable {
  const AqiByConditionEvent();

  @override
  List<Object> get props => [];
}

class GetAqiByCondition extends AqiByConditionEvent {}

class UpdateAqiByCondition extends AqiByConditionEvent {
  UpdateAqiByCondition({@required this.condition});

  final ConditionEnum condition;

  @override
  List<Object> get props => [condition];
}
