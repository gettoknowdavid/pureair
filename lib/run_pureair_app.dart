import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'dependency_injector.dart';
import 'features/aqi/presentation/blocs/aqi_by_condition_bloc.dart';
import 'features/favourites/presentation/bloc/favourites_bloc.dart';
import 'features/search/presentation/blocs/search_aqi/search_aqi_bloc.dart';
import 'features/search/presentation/blocs/search_details/search_details_bloc.dart';

void runPureAirApp() {
  return runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<BottomNavBloc>()),
        BlocProvider(
          create: (context) => sl<AqiByConditionBloc>()..add(GetAqiByCondition()),
        ),
        BlocProvider(create: (context) => sl<SearchAqiBloc>()),
        BlocProvider(create: (context) => sl<SearchDetailsBloc>()),
        BlocProvider(
          create: (context) => sl<FavouritesBloc>()..add(GetFavourites()),
        ),
      ],
      child: App(),
    ),
  );
}
