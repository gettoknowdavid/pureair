part of 'model_bloc.dart';

abstract class ModelState extends Equatable {
  const ModelState();
  @override
  List<Object> get props => [];
}

class ModelLoading extends ModelState {}

class ModelLoaded extends ModelState {
  final PureAir pureAir;

  ModelLoaded(this.pureAir);

  @override
  List<Object> get props => [pureAir];
}

class ModelNotLoaded extends ModelState {}
