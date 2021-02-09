import 'package:flutter/material.dart';
import 'favourites_list_item.dart';
import '../../../search/domain/entities/search_data.dart';

class FavouritesList extends StatelessWidget {
  const FavouritesList({Key key, @required this.cities}) : super(key: key);

  final List<SearchData> cities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(26, 0, 26, 26),
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return FavouriteListItem(city: city);
      },
    );
  }
}
