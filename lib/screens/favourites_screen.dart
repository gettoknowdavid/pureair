import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/favourites/favourites_bloc.dart';
import 'package:pureair/blocs/situation_helper.dart';
import 'package:pureair/screens/details_screen.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/favourite_widget.dart';
import 'package:pureair/widgets/loading_indicator.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class FavouritesScreen extends StatefulWidget {
  final double width;
  final double height;
  final bool showAppBar;

  const FavouritesScreen({
    Key key,
    this.width,
    this.height,
    this.showAppBar: true,
  }) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController;
  FavouritesBloc get favouritesBloc => BlocProvider.of<FavouritesBloc>(context);

  Size get size => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    // _connSubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnStatus);
  }

  @override
  void dispose() {
    // _connSubscription.cancel();
    super.dispose();
  }

  // Future<void> _updateConnStatus(ConnectivityResult result) async {
  //   if (result == ConnectivityResult.none) {
  //     try {
  //       favouritesBloc.add(LoadFavourites());
  //     } catch (_) {
  //       favouritesBloc.add(RefreshFavourites());
  //     }
  //   } else {
  //     favouritesBloc.add(RefreshFavourites());
  //   }
  // }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   if (!mounted) return Future.value(null);

  //   return _updateConnStatus(result);
  // }

  // _modalBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     isDismissible: true,
  //     builder: (context) {
  //       return CheckConnectionWidget(size: size);
  //     },
  //   );
  // }

  // get refresher async {
  //   var result = await _connectivity.checkConnectivity();

  //   if (result == ConnectivityResult.none) {
  //     try {
  //       favouritesBloc.add(LoadFavourites());
  //     } catch (_) {
  //       _modalBottomSheet();
  //     }
  //   } else {
  //     favouritesBloc.add(RefreshFavourites());
  //   }
  // }

  bool showRemoveButtons = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: widget.showAppBar
          ? PureAirAppBar(
              leading: PureAirBackButton(),
              title: 'FAVOURITES',
              actions: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      favouritesBloc.add(RefreshFavourites());
                    },
                  ),
                  IconButton(
                    icon: !showRemoveButtons
                        ? Icon(Icons.cancel, color: Colors.red)
                        : Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        showRemoveButtons = !showRemoveButtons;
                      });
                    },
                  ),
                ],
              ),
            )
          : null,
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoaded) {
            // final safeCities = state.safeCities;
            // final flaggedCities = state.safeCities;

            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: WaterDropHeader(),
              onRefresh: () async {
                favouritesBloc.add(RefreshFavourites());
                await Future.delayed(Duration(seconds: 5));
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                primary: false,
                padding: EdgeInsets.symmetric(vertical: 26),
                itemCount: state.favourites.favModels.length,
                itemBuilder: (context, index) {
                  final model = state.favourites.favModels[index];
                  // print('FROM FAVOURITE SCREEN ${state.favModels.map((e) => e.data.city.name)}');
                  final data = model.data;
                  Geo geo = Geo(
                    lat: data.city.geo[0],
                    lon: data.city.geo[1],
                  );
                  final helper = AqiHelper(model);
                  final situationHelper = SituationHelper();
                  final message =
                      situationHelper.tailoredMessage(state.situation, model);
                  final pollutants =
                      situationHelper.pollutants(state.situation, model);

                  Favourites flaggedCities = situationHelper.flagged(
                      state.favourites, state.situation);
                  Aqi flaggedModel;
                  for (Aqi ff in flaggedCities.favModels) {
                    flaggedModel = ff;
                  }

                  return FavouriteWidget(
                    size: size,
                    data: data,
                    helper: helper,
                    flagged:
                        model.data.dominentpol == flaggedModel.data.dominentpol,
                    onTap: () {
                      Navigator.push(
                        context,
                        FadePageRoute(
                          widget: DetailsScreen(
                            model: model,
                            situation: state.situation,
                            message: message,
                            pollutants: pollutants,
                          ),
                        ),
                      );
                    },
                    showRemoveButtons: showRemoveButtons,
                    remove: () {
                      print(data.idx);
                      favouritesBloc.add(RemoveFavourite(
                        geo,
                        data.idx,
                        key: _scaffoldKey,
                      ));
                      // showRemoveButtons = !showRemoveButtons;
                    },
                  );
                },
              ),
            );
          } else if (state is FavouritesLoading) {
            return LoadingIndicator();
          } else {
            return Container(
              child: Center(
                child: Text('NOTHING HERE'),
              ),
            );
          }
        },
      ),
    );
  }
}
