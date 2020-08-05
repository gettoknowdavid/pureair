import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/model/model_bloc.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/data.dart';
import 'package:pureair/widgets/aqi_widget.dart';
import 'package:pureair/widgets/check_connection_widget.dart';
import 'package:pureair/widgets/error_screen.dart';
import 'package:pureair/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController;
  ModelBloc get modelBloc => BlocProvider.of<ModelBloc>(context);
  StreamSubscription<ConnectivityResult> _connSubscription;

  Size get size => MediaQuery.of(context).size;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _connSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnStatus);
  }

  @override
  void dispose() {
    _connSubscription.cancel();
    super.dispose();
  }

  DbRepository repo = DbRepository();
  Dao dao = Dao();

  Future<Aqi> ggg(lat, lon) async {
    return await dao.fetchSearchDetails(lat, lon);
  }

  Future<void> _updateConnStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      try {
        modelBloc.add(LoadModel());
      } catch (_) {
        modelBloc.add(RefreshModel());
      }
    } else {
      modelBloc.add(RefreshModel());
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
        modelBloc.add(LoadModel());
      } catch (_) {
        _modalBottomSheet();
      }
    } else {
      modelBloc.add(RefreshModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final aqiWidgetHeight = size.height * 0.6;
    final aqiWidgetWidth = size.width;

    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          await refresher;
          _refreshController.refreshCompleted();
        },
        child: BlocBuilder<ModelBloc, ModelState>(
          builder: (context, state) {
            if (state is ModelLoaded) {
              AqiHelper helper = AqiHelper(state.model);

              return SingleChildScrollView(
                // shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 12),
                primary: true,
                child: Column(
                  children: <Widget>[
                    AqiWidget(
                      model: state.model,
                      helper: helper,
                      height: aqiWidgetHeight,
                      width: aqiWidgetWidth,
                    ),
                    SizedBox(height: 40),
                    // ListView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: state.favModels.length,
                    //   itemBuilder: (context, index) {
                    //     AqiHelper _helper = AqiHelper(state.favModels[index]);
                    //     final data = state.favModels[index].data;
                    //     final id = state.savedStations[index].id;

                    //     return FavouriteWidget(
                    //       size: size,
                    //       data: data,
                    //       onTap: () {
                    //         modelBloc.add(RemoveFavourite(data, id: id));
                    //       },
                    //       helper: _helper,
                    //     );
                    //   },
                    // ),
                  ],
                ),
              );
            } else if (state is ModelNotLoaded) {
              return ErrorScreen(
                size: size,
                title: 'Please check your internet connection and try again.',
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

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({
    Key key,
    @required this.size,
    @required this.data,
    @required this.onTap,
    @required AqiHelper helper,
  })  : _helper = helper,
        super(key: key);

  final Size size;
  final Data data;
  final VoidCallback onTap;
  final AqiHelper _helper;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.2,
        width: size.width,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.city.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline5,
                  ),
                  Text(
                    _helper.healthConcern,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline6,
                  ),
                ],
              ),
            ),
            Container(
              height: (size.height * 0.2) * 0.5,
              width: (size.height * 0.2) * 0.5,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _helper.backgroundColor,
              ),
              child: AutoSizeText(
                data.aqi.toString(),
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: textTheme.headline1.copyWith(
                  fontWeight: FontWeight.w900,
                  color: _helper.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
