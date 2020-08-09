part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesLoading extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesLoaded extends FavouritesState {
  final Favourites favourites;
  final SituationEnum situation;


  FavouritesLoaded(this.favourites,  this.situation);

  @override
  List<Object> get props => [favourites,  situation];
}

class FavouritesNotLoaded extends FavouritesState {
  @override
  List<Object> get props => [];
}
