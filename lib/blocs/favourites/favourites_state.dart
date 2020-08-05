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

  FavouritesLoaded(this.favourites);

  @override
  List<Object> get props => [favourites];
}

class FavouritesNotLoaded extends FavouritesState {
  @override
  List<Object> get props => [];
}
