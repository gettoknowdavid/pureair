part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class LoadFavourites extends FavouritesEvent {
  @override
  List<Object> get props => [];
}

class RefreshFavourites extends FavouritesEvent {
  @override
  List<Object> get props => [];
}

class AddFavourite extends FavouritesEvent {
  final GlobalKey<ScaffoldState> key;
  final Geo geo;

  AddFavourite(this.geo, {this.key});

  @override
  List<Object> get props => [geo, key];
}

class RemoveFavourite extends FavouritesEvent {
  final Geo geo;
  final int idx;
  final GlobalKey<ScaffoldState> key;
  

  RemoveFavourite(this.geo, this.idx, {this.key});

  @override
  List<Object> get props => [geo, idx, key];
}
