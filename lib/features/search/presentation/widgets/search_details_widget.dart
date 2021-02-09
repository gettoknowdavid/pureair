import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../aqi/presentation/screens/details/details_screen.dart';
import '../../domain/entities/search_data.dart';
import '../blocs/search_details/search_details_bloc.dart';

class SearchDetailsWidget extends StatefulWidget {
  const SearchDetailsWidget({Key key, @required this.data}) : super(key: key);

  final SearchData data;

  @override
  _SearchDetailsWidgetState createState() => _SearchDetailsWidgetState();
}

class _SearchDetailsWidgetState extends State<SearchDetailsWidget> {
  SearchDetailsBloc get bloc => BlocProvider.of<SearchDetailsBloc>(context);

  @override
  void initState() {
    final geo = widget.data.station.geo;

    bloc.add(GetSearchDetailsEvent(lat: geo[0], lon: geo[1]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchDetailsBloc, SearchDetailsState>(
      cubit: bloc,
      builder: (context, state) {
        if (state is SearchDetailsLoaded) {
          return DetailsScreen(aqiByCondition: state.data);
        } else if (state is SearchDetailsLoading) {
          return LoadingIndicator();
        } else {
          return ErrorScreen(
            title: 'Please check your internet connection and try again.',
          );
        }
      },
    );
  }
}
