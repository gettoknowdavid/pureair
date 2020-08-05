part of 'model_bloc.dart';

abstract class ModelEvent extends Equatable {
  const ModelEvent();
  @override
  List<Object> get props => [];
}

class LoadModel extends ModelEvent {}

class RefreshModel extends ModelEvent {}
