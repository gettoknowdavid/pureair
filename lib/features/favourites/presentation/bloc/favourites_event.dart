part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavourites extends FavouritesEvent {}

class AddFavourite extends FavouritesEvent {
  AddFavourite({@required this.city});
  final SearchData city;
  @override
  List<Object> get props => [city];
}

class RemoveFavourite extends FavouritesEvent {
  RemoveFavourite({@required this.city});
  final SearchData city;
  @override
  List<Object> get props => [city];
}
