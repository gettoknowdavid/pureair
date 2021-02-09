import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/widgets/check_connection_widget.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../blocs/aqi_by_condition_bloc.dart';
import '../widgets/aqi_widget.dart';

class AqiScreen extends StatefulWidget {
  @override
  _AqiScreenState createState() => _AqiScreenState();
}

class _AqiScreenState extends State<AqiScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController;
  NetworkInfo networkInfo;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        key: _scaffoldKey,
        body: _buildBody(context),
      ),
    );
  }

  SmartRefresher _buildBody(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropHeader(),
      onRefresh: () async => _onRefresh(context),
      child: _buildBloc(),
    );
  }

  Future<void> refresher(BuildContext context) async {
    if (networkInfo == null) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        elevation: 300,
        builder: (context) => CheckConnectionWidget(),
      );
    } else {
      context.read<AqiByConditionBloc>()..add(GetAqiByCondition());
    }
  }

  _onRefresh(BuildContext context) async {
    await refresher(context);
    await Future.delayed(Duration(seconds: 5));
    _refreshController.refreshCompleted();
  }

  BlocBuilder<AqiByConditionBloc, AqiByConditionState> _buildBloc() {
    return BlocBuilder<AqiByConditionBloc, AqiByConditionState>(
      builder: (context, state) {
        if (state is AqiByConditionLoaded) {
          return AqiWidget(aqiByCondition: state.aqiByCondition);
        } else if (state is AqiByConditionError) {
          return ErrorScreen(title: state.message);
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
