import 'package:flutter/material.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class SearchDetailsScreen extends StatelessWidget {
  const SearchDetailsScreen({Key key, @required this.data}) : super(key: key);

  final SearchData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PureAirAppBar(
        leading: PureAirBackButton(),
      ),
      body: Container(
        child: Text(data.aqi),
      ),
    );
  }
}
