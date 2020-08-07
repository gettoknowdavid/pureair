import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/favourites/favourites_bloc.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/error_screen.dart';
import 'package:pureair/widgets/loading_indicator.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class FavouritesSettings extends StatefulWidget {
  @override
  _FavouritesSettingsState createState() => _FavouritesSettingsState();
}

class _FavouritesSettingsState extends State<FavouritesSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FavouritesBloc get favouritesBloc => BlocProvider.of<FavouritesBloc>(context);

  @override
  void initState() {
    super.initState();
    favouritesBloc.add(LoadFavourites());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final listTilePadding = EdgeInsets.symmetric(vertical: 6);

    Widget _buildListTile(String title, Geo geo, int idx,
        {VoidCallback onTap}) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headline5.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onBackground,
              ),
            ),
            contentPadding: listTilePadding,
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                favouritesBloc
                    .add(RemoveFavourite(geo, idx, key: _scaffoldKey));
              },
            ),
          ),
          Divider(),
        ],
      );
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        key: _scaffoldKey,
        appBar:
            PureAirAppBar(leading: PureAirBackButton(), title: 'FAVOURITES'),
        body: BlocBuilder<FavouritesBloc, FavouritesState>(
          cubit: favouritesBloc,
          builder: (context, state) {
            if (state is FavouritesLoaded) {
              return ListView.builder(
                padding: EdgeInsets.all(26),
                itemCount: state.favourites.favModels.length,
                itemBuilder: (context, index) {
                  final data = state.favourites.favModels[index].data;
                  final geo = state.favourites.geos[index];
                  final idx = data.idx;

                  return _buildListTile(data.city.name, geo, idx);
                },
              );
            } else if (state is FavouritesNotLoaded) {
              return ErrorScreen(
                size: MediaQuery.of(context).size,
                title: 'Something is wrong, please try again.',
              );
            } else {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
