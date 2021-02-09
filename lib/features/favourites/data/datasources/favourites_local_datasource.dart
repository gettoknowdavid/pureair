import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../../../search/domain/entities/search_data.dart';

final store = intMapStoreFactory.store('${env['FAVOURITE_STORE']}');

abstract class FavouritesLocalDataSource {
  Future<List<SearchData>> getFavourites();

  Future<void> addFavourite(SearchData city);

  Future<void> removeFavourite(SearchData city);
}

class FavouritesLocalDataSourceImplementation
    implements FavouritesLocalDataSource {
  FavouritesLocalDataSourceImplementation({@required this.database});
  final Database database;

  @override
  Future<void> addFavourite(SearchData city) async {
    final _finder = Finder(sortOrders: [SortOrder('key', true)]);

    final _records = await store.find(database, finder: _finder);

    final _cities = _records.map((e) => SearchData.fromJson(e.value)).toList();

    final _uids = _cities.map((e) => e.uid).toList();

    if (_uids.contains(city.uid)) {
      return null;
    } else {
      return await store.add(database, city.toJson());
    }
  }

  @override
  Future<List<SearchData>> getFavourites() async {
    final _finder = Finder(sortOrders: [SortOrder('key', true)]);

    final _records = await store.find(database, finder: _finder);

    return _records.map((e) => SearchData.fromJson(e.value)).toList();
  }

  @override
  Future<void> removeFavourite(SearchData city) async {
    final uid = city.uid;

    final _finder = Finder(filter: Filter.equals('uid', uid));

    final _record = await store.findFirst(database, finder: _finder);

    final key = _record.key;

    await store.record(key).delete(database);
  }
}
