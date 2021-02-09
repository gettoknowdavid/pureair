part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

class FavouritesEmpty extends FavouritesState {
  // FavouritesEmpty({this.cities = const <SearchData>[]});
  // final List<SearchData> cities;
  // @override
  // List<Object> get props => [cities];
}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  FavouritesLoaded({@required this.cities});
  final List<SearchData> cities;
  @override
  List<Object> get props => [cities];
}

class FavouritesError extends FavouritesState {
  FavouritesError({@required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
