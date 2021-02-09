import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../bloc/favourites_bloc.dart';
import '../widgets/favourites_list.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FAVOURITES',
        leading: CustomBackButton(),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoaded) {
            return state.cities.length == 0
                ? EmptyWidget()
                : FavouritesList(cities: state.cities);
          } else if (state is FavouritesError) {
            return ErrorScreen(title: state.message);
          } else if (state is FavouritesEmpty) {
            return Center(
              child: Text('Feels lonely here, add favourite cities.'),
            );
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28),
      child: Text(
        'Feels lonely here, you can add your favourite cities now.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
