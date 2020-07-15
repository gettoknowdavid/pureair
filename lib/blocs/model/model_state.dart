part of 'model_bloc.dart';

abstract class ModelState extends Equatable {
  const ModelState();
  @override
  List<Object> get props => [];
}

class ModelLoading extends ModelState {}

class ModelLoaded extends ModelState {
  final Aqi model;

  ModelLoaded(this.model);

  @override
  List<Object> get props => [model];
}

class ModelNotLoaded extends ModelState {}
