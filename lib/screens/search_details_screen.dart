import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/blocs/search_details/search_details_bloc.dart';
import 'package:pureair/screens/details_screen.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/error_screen.dart';
import 'package:pureair/widgets/loading_indicator.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class SearchDetailsScreen extends StatefulWidget {
  const SearchDetailsScreen({Key key, @required this.data}) : super(key: key);

  final SearchData data;

  @override
  _SearchDetailsScreenState createState() => _SearchDetailsScreenState();
}

class _SearchDetailsScreenState extends State<SearchDetailsScreen> {
  SearchDetailsBloc get bloc => BlocProvider.of<SearchDetailsBloc>(context);
  @override
  void initState() {
    final geo = widget.data.station.geo;

    bloc.add(FetchSearchDetails(geo[0], geo[1]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchDetailsBloc, SearchDetailsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is SearchDetailsLoaded) {
          return DetailsScreen(model: state.model);
        } else if (state is SearchDetailsLoading) {
          return LoadingIndicator(
            size: MediaQuery.of(context).size,
          );
        } else {
          return ErrorScreen(
            size: MediaQuery.of(context).size,
            title: 'Please check your internet connection and try again.',
          );
        }
      },
    );
  }
}
