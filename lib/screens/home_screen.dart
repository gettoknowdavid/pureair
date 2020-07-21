import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/model/model_bloc.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/widgets/air_purifier_image.dart';
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
              
              return ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(vertical: 16),
                children: <Widget>[
                  AqiWidget(
                    model: state.model,
                    helper: helper,
                    height: aqiWidgetHeight,
                    width: aqiWidgetWidth,
                  ),
                  SizedBox(height: 40),
                  AirPurifierImage(
                    size: size,
                    height: aqiWidgetHeight,
                    width: aqiWidgetWidth,
                  ),
                ],
              );
            } else if (state is ModelNotLoaded) {
              return ErrorScreen(
                size: size,
                title: 'Please check your internet connection and try again.',
              );
            } else {
              return LoadingIndicator(size: size);
            }
          },
        ),
      ),
    );
  }
}
