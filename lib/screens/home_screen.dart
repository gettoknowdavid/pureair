import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/model/model_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/widgets/aqi_widget.dart';
import 'package:pureair/widgets/check_connection_widget.dart';
import 'package:pureair/widgets/error_screen.dart';
import 'package:pureair/widgets/loading_indicator.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:pureair/widgets/pureair_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController = RefreshController();
  ModelBloc get modelBloc => BlocProvider.of<ModelBloc>(context);
  StreamSubscription<ConnectivityResult> _connSubscription;

  Size get size => MediaQuery.of(context).size;
  final Connectivity _connectivity = Connectivity();
  VoidCallback _bottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _connSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnStatus);
    _bottomSheetCallBack = _showBottomSheet;
  }

  @override
  void dispose() {
    _connSubscription.cancel();
    super.dispose();
  }

  void _showBottomSheet() {
    setState(() {
      _bottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet(
          (context) => PureAirBottomSheet(
            size: size,
            close: () => Navigator.pop(context),
          ),
          elevation: 100,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
        )
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheetCallBack = _showBottomSheet;
        });
      }
    });
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

  refresher(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _modalBottomSheet();
      try {
        modelBloc.add(LoadModel());
      } catch (_) {
        modelBloc.add(RefreshModel());
      }
    } else {
      modelBloc.add(RefreshModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final aqiWidgetHeight = size.longestSide * 0.6;
    final aqiWidgetWidth = size.shortestSide;

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        await refresher(context);
        _refreshController.refreshCompleted();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PureAirAppBar(
          title: 'HOME',
          actions: IconButton(
            icon: Icon(Icons.add),
            onPressed: _bottomSheetCallBack,
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(vertical: 26),
          children: <Widget>[
            BlocBuilder<ModelBloc, ModelState>(
              builder: (context, state) {
                if (state is ModelLoaded) {
                  return AqiWidget(
                    model: state.model,
                    height: aqiWidgetHeight,
                    width: aqiWidgetWidth,
                  );
                } else if (state is ModelNotLoaded) {
                  return ErrorScreen(size: size);
                } else {
                  return LoadingIndicator(size: size);
                }
              },
            ),
            SizedBox(height: 30),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is StoredStations) {
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.stations.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(state.stations[index].aqi),
                      );
                    },
                  );
                } else {
                  return Container(
                    height: 30,
                    color: Colors.pink,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
