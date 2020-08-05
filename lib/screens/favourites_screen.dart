import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/favourites/favourites_bloc.dart';
import 'package:pureair/blocs/favourites/favourites_bloc.dart';
import 'package:pureair/screens/details_screen.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/data.dart';
import 'package:pureair/src/model/search_model/geo.dart';
import 'package:pureair/widgets/check_connection_widget.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/loading_indicator.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class FavouritesScreen extends StatefulWidget {
  final double width;
  final double height;

  const FavouritesScreen({Key key, this.width, this.height}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController;
  FavouritesBloc get favouritesBloc => BlocProvider.of<FavouritesBloc>(context);
  StreamSubscription<ConnectivityResult> _connSubscription;

  Size get size => MediaQuery.of(context).size;
  final Connectivity _connectivity = Connectivity();

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _connSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnStatus);
    refresher;

    _refreshCompleter = Completer<void>();
  }

  @override
  void dispose() {
    _connSubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      try {
        favouritesBloc.add(LoadFavourites());
      } catch (_) {
        favouritesBloc.add(RefreshFavourites());
      }
    } else {
      favouritesBloc.add(RefreshFavourites());
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) return Future.value(null);

    return _updateConnStatus(result);
  }

  _modalBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) {
        return CheckConnectionWidget(size: size);
      },
    );
  }

  get refresher async {
    var result = await _connectivity.checkConnectivity();

    if (result == ConnectivityResult.none) {
      try {
        favouritesBloc.add(LoadFavourites());
      } catch (_) {
        _modalBottomSheet();
      }
    } else {
      favouritesBloc.add(RefreshFavourites());
    }
  }

  bool showRemoveButtons = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final mainContainerHeight = size.height * 0.16;
    final aqiContainerSize = mainContainerHeight * 0.6;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: PureAirAppBar(
        leading: PureAirBackButton(),
        title: 'FAVOURITES',
        actions: IconButton(
          icon: !showRemoveButtons
              ? Icon(Icons.cancel, color: Colors.red)
              : Icon(Icons.edit),
          onPressed: () {
            setState(() {
              showRemoveButtons = !showRemoveButtons;
            });
          },
        ),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoaded) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: WaterDropHeader(),
              onRefresh: () async {
                await refresher;
                await Future.delayed(Duration(seconds: 5));
                _refreshController.refreshCompleted();
              },
              child: ListView.builder(
                primary: false,
                padding: EdgeInsets.symmetric(vertical: 26),
                itemCount: state.favourites.favModels.length,
                itemBuilder: (context, index) {
                  final model = state.favourites.favModels[index];
                  final data = model.data;
                  Geo geo = Geo(
                    lat: data.city.geo[0],
                    lon: data.city.geo[1],
                  );
                  final helper = AqiHelper(model);
                  return FavouriteWidget(
                    size: size,
                    data: data,
                    helper: helper,
                    onTap: () {
                      Navigator.push(
                        context,
                        FadePageRoute(widget: DetailsScreen(model: model)),
                      );
                    },
                    showRemoveButtons: showRemoveButtons,
                    remove: () {
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

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({
    Key key,
    this.size,
    this.data,
    this.onTap,
    this.showRemoveButtons,
    this.remove,
    AqiHelper helper,
  })  : _helper = helper,
        super(key: key);

  final Size size;
  final Data data;
  final VoidCallback onTap;
  final bool showRemoveButtons;
  final VoidCallback remove;
  final AqiHelper _helper;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final mainContainerHeight = size.height * 0.14;
    final aqiContainerSize = mainContainerHeight * 0.5;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mainContainerHeight,
        width: size.width,
        // padding: EdgeInsets.all(16),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: Stack(
          children: <Widget>[
            Material(
              elevation: 20,
              shadowColor: Colors.black26,
              color: theme.brightness == Brightness.light
                  ? Colors.white
                  : colorScheme.background,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data != null ? data.city.name : 'Sorry no city',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline4,
                          ),
                          SizedBox(height: 10),
                          Text(
                            data != null
                                ? _helper.healthConcern
                                : 'Okay, the air is...empty!',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline6,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'DOMINANT POLLUTANT: ',
                                style: textTheme.subtitle1.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  color: textTheme.subtitle1.color
                                      .withOpacity(0.7),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 30,
                                width: 50,
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: AutoSizeText(
                                  _helper.dominantPol,
                                  style: textTheme.headline6.copyWith(
                                    color: colorScheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: aqiContainerSize,
                      width: aqiContainerSize,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(right: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: data != null
                            ? _helper.backgroundColor
                            : colorScheme.background,
                      ),
                      child: AutoSizeText(
                        data != null ? data.aqi.toString() : '-',
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: textTheme.headline1.copyWith(
                          fontWeight: FontWeight.w900,
                          color: data != null
                              ? _helper.color
                              : colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            showRemoveButtons
                ? Container()
                : Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: remove,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
