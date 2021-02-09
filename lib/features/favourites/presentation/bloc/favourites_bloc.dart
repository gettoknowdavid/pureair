import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../search/domain/entities/search_data.dart';
import '../../domain/usecases/add_favourite_usecase.dart';
import '../../domain/usecases/get_favourites_usecase.dart';
import '../../domain/usecases/parameters/favourites_params.dart';
import '../../domain/usecases/remove_favourite_usecase.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc({
    @required this.getFavourites,
    @required this.addFavourite,
    @required this.removeFavourite,
  }) : super(FavouritesEmpty());
  final GetFavouritesUseCase getFavourites;
  final AddFavouriteUseCase addFavourite;
  final RemoveFavouriteUseCase removeFavourite;

  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    if (event is AddFavourite) {
      await addFavourite(FavouritesParams(city: event.city));

      final cities = await getFavourites(NoParams());

      yield* _mapEitherToState(cities);
    } else if (event is RemoveFavourite) {
      await removeFavourite(FavouritesParams(city: event.city));

      final cities = await getFavourites(NoParams());

      yield* _mapEitherToState(cities);
    } else if (event is GetFavourites) {
      final cities = await getFavourites(NoParams());

      yield* _mapEitherToState(cities);
    }
  }

  Stream<FavouritesState> _mapEitherToState(
      Either<Failure, List<SearchData>> result) async* {
    yield result.fold(
      (failure) => FavouritesError(message: _mapFailureToMessage(failure)),
      (cities) => FavouritesLoaded(cities: cities),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: Failed to fetch from server air quality.';
      case DatabaseFailure:
        return 'Database Error: Failed to load last air quality from store.';
      default:
        return 'Unexpected Error';
    }
  }
}
