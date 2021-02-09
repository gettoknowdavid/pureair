import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favourites/presentation/bloc/favourites_bloc.dart';
import '../../domain/entities/search_data.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({Key key, @required this.clickedCity})
      : super(key: key);
  final SearchData clickedCity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // ignore: close_sinks
    final cubit = context.read<FavouritesBloc>();

    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        if (state is FavouritesLoaded) {
          List<int> _cityUids = state.cities.map((e) => e.uid).toList();
          bool isFavourited = _cityUids.contains(clickedCity.uid);

          return IconButton(
            icon: isFavourited
                ? Icon(Icons.favorite, color: colorScheme.error)
                : Icon(Icons.favorite_border),
            onPressed: () {
              cubit..add(isFavourited
                ? RemoveFavourite(city: clickedCity)
                : AddFavourite(city: clickedCity));
            },
          );
        } else {
          return IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              cubit..add(AddFavourite(city: clickedCity));
            },
          );
        }
      },
    );
  }
}
