import 'package:flutter/material.dart';

import '../../domain/entities/search_aqi.dart';
import 'search_result_item.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({Key key, @required this.searchAqi}) : super(key: key);

  final SearchAqi searchAqi;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      itemCount: searchAqi.data.length,
      itemBuilder: (context, index) {
        final data = searchAqi.data[index];
        return SearchResultItem(searchResult: data);
      },
    );
  }
}
