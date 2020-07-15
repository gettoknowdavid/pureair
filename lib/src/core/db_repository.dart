import 'dart:convert';

import 'package:pureair/src/core/pureair_dao.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/database/pureair_database.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/src/model/search_model/search.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:sembast/sembast.dart';

class DbRepository extends Repository {
  static const String AQI_STORE_NAME = '__air_quality__';
  static const String THEME_STORE_NAME = '__theme_store__';
  static const String SEARCH_STORE_NAME = '__search_store__';

  final store = intMapStoreFactory.store(AQI_STORE_NAME);
  final themeStore = intMapStoreFactory.store(THEME_STORE_NAME);
  final searchStore = intMapStoreFactory.store(SEARCH_STORE_NAME);

  Future<Database> get _database async =>
      await PureAirDatabase.instance.database;

  Dao dao = Dao();

  @override
  Future<Aqi> get fetchModel async {
    await store.drop(await _database);

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
  Future<PureAirTheme> get loadTheme async {
    final _record = await themeStore.record(1).get(await _database);

    return _record == null ? null : PureAirTheme.fromJson(_record);
  }

  @override
  Future saveModel(Aqi model) async {
    await store.add(await _database, model.toJson());
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

  @override
  Future<Search> get loadSearchModel async {
    final record = await searchStore.record(1).get(await _database);

    return record == null ? null : Search.fromJson(record);
  }

  @override
  Future saveSearchModel(Search search) async {
    await searchStore.add(await _database, search.toJson());
  }
}
