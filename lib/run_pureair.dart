import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/app.dart';
import 'package:pureair/blocs/model/model_bloc.dart';
import 'package:pureair/blocs/pureair_observer.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/blocs/search_details/search_details_bloc.dart';
import 'package:pureair/blocs/tabs/tabs_bloc.dart';
import 'package:pureair/src/core/repository.dart';

void runPureAir(Repository repository) async {
  Bloc.observer = PureAirBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TabsBloc()),
        BlocProvider(
          create: (context) {
            return ModelBloc(repository);
          },
        ),
        BlocProvider(
          create: (context) {
            return SearchBloc(repository);
          },
        ),
        BlocProvider(
          create: (context) {
            return SearchDetailsBloc();
          },
        ),
      ],
      child: App(),
    ),
  );
}
