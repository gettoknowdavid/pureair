import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/model/model_bloc.dart';
import 'package:pureair/widgets/air_purifier_image.dart';
import 'package:pureair/widgets/aqi_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  Size get size => MediaQuery.of(context).size;
  ModelBloc get modelBloc => BlocProvider.of<ModelBloc>(context);
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      modelBloc.add(LoadModel());
    } else {
      modelBloc.add(RefreshModel());
    }
  }

  _modalBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) {
        return Container(
          height: size.shortestSide * 0.3,
          width: size.width,
          alignment: Alignment.topCenter,
          child: Container(
            height: size.height * 0.1,
            width: size.width * 0.92,
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              'Please check your internet connection and try again.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  refresher(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _modalBottomSheet();
      modelBloc.add(LoadModel());
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
      child: BlocBuilder<ModelBloc, ModelState>(
        builder: (context, state) {
          if (state is ModelLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ModelLoaded) {
            return ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(vertical: 26),
              children: <Widget>[
                AqiWidget(
                  model: state.model,
                  height: aqiWidgetHeight,
                  width: aqiWidgetWidth,
                ),
                SizedBox(height: 40),
                AirPurifierImage(
                  size: size,
                  height: aqiWidgetHeight,
                  width: aqiWidgetWidth,
                  onPressed: () {},
                ),
              ],
            );
          } else if (state is ModelNotLoaded) {
            return ErrorScreen(size: size);
          } else {
            return Center(
              child: Container(
                height: size.shortestSide * 0.4,
                width: size.shortestSide * 0.9,
                decoration: BoxDecoration(
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 70,
                    ),
                  ],
                ),
                child: Card(
                  elevation: 200,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        height: size.shortestSide * 0.4,
        width: size.shortestSide * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 70,
            ),
          ],
        ),
        child: Card(
          elevation: 200,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: textTheme.headline5.copyWith(),
            ),
          ),
        ),
      ),
    );
  }
}
