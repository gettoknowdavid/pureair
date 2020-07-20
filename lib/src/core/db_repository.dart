import 'dart:convert';

import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/database/pureair_database.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/src/model/pureair.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:sembast/sembast.dart';

class DbRepository extends Repository {
  static const String AQI_STORE_NAME = '__air_quality__';
  static const String THEME_STORE_NAME = '__theme_store__';
  static const String PUREAIR_STORE_NAME = '__pureair_store__';

  // final store = intMapStoreFactory.store(AQI_STORE_NAME);
  final themeStore = intMapStoreFactory.store(THEME_STORE_NAME);
  final store = intMapStoreFactory.store(PUREAIR_STORE_NAME);

  Future<Database> get _database async =>
      await PureAirDatabase.instance.database;

  Dao dao = Dao();

  @override
  Future<Aqi> get fetchModel async {
    var source = jsonEncode(await dao.fetchAqi());
    var json = jsonDecode(source);
    var main = Aqi.fromJson(json);
    return main;
  }

  @override
  Future<Aqi> get loadModel async {
    final record = await store.record(1).get(await _database);

    return record == null ? null : Aqi.fromJson(record);
  }

  @override
  Future saveModel(Aqi model) async {
    await store.add(await _database, model.toJson());
  }

  @override
  Future get clearAqiStore async => await store.drop(await _database);

  test() async {
    // Add the data and get its new generated key
    var key = await store.add(await _database, {'value': 'test'});

// Retrieve the record
    var record = store.record(key);
    var readMap = await record.get(await _database);

    print(readMap);
  }

  @override
  Future<PureAir> get loadPureAir async {
    final finder = Finder(sortOrders: [SortOrder("timeStamp", false)]);

    final snapshot = await store.find(await _database, finder: finder);

    var source = jsonEncode(await dao.fetchAqi());


    return snapshot.map((snapshot) {
      final pureAir = PureAir.fromJson(snapshot.value);
      final timeStamp = DateTime.now().toIso8601String();

      var json = jsonDecode(source);

      pureAir.id = snapshot.key;
      pureAir.model = Aqi.fromJson(json);
      pureAir.timeStamp = timeStamp;

      print(pureAir);
      return pureAir;
    }).last;
    // final record = await store.record(key)
  }



  @override
  Future savePureAir(PureAir pureAir) async {
    await store.add(await _database, pureAir.toJson());
  }

  @override
  Future<PureAirTheme> get loadTheme async {
    final _record = await themeStore.record(1).get(await _database);
    return _record == null ? null : PureAirTheme.fromJson(_record);
  }

  @override
  Future saveTheme(PureAirTheme theme) async {
    await themeStore.add(await _database, theme.toJson());
  }

  @override
  Future get clearThemeStore async => await themeStore.drop(await _database);

  @override
  Future<SearchAqi> searchModel(String city) async {
    // await store.drop(await _database);
    var source = jsonEncode(await dao.searchAqi(city));
    var json = jsonDecode(source);
    var main = SearchAqi.fromJson(json);
    return main;
  }
}
