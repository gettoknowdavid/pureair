import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/situation/situation_bloc.dart';
import 'package:pureair/screens/details_screen.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/widgets/aqi_widget.dart';
import 'package:pureair/widgets/check_connection_widget.dart';
import 'package:pureair/widgets/error_screen.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController;
  SituationBloc get situationBloc => BlocProvider.of<SituationBloc>(context);
  StreamSubscription<ConnectivityResult> _connSubscription;

  Size get size => MediaQuery.of(context).size;
  final Connectivity _connectivity = Connectivity();

  FlutterLocalNotificationsPlugin notifications;

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

  Future<void> _updateConnStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      try {
        situationBloc.add(LoadSituation());
      } catch (_) {
        situationBloc.add(FetchModel());
      }
    } else {
      situationBloc.add(FetchModel());
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
        situationBloc.add(LoadSituation());
      } catch (_) {
        _modalBottomSheet();
      }
    } else {
      situationBloc.add(FetchModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final aqiWidgetHeight = size.height;
    final aqiWidgetWidth = size.width;

    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(),
        onRefresh: () async {
          await refresher;
          await Future.delayed(Duration(seconds: 5));
          _refreshController.refreshCompleted();
        },
        child: BlocBuilder<SituationBloc, SituationState>(
          builder: (context, state) {
            if (state is SituationLoaded) {
              AqiHelper helper = AqiHelper(state.model);
              print(state.situation);

              return AqiWidget(
                model: state.model,
                message: state.message,
                helper: helper,
                height: double.infinity,
                width: aqiWidgetWidth,
                onTap: () async {
                  Navigator.of(context).push(
                    FadePageRoute(
                      widget: DetailsScreen(
                        model: state.model,
                        situation: state.situation,
                        message: state.message,
                        pollutants: state.pollutants,
                      ),
                    ),
                  );
                },
              );
            } else if (state is SituationNotLoaded) {
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
