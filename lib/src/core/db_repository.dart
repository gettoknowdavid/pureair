import 'package:pureair/src/core/base_model.dart';
import 'package:pureair/src/core/dao.dart';
import 'package:pureair/src/core/repository.dart';
import 'package:pureair/src/database/pureair_database.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:sembast/sembast.dart';

class DbRepository extends Repository {
  static const String AQI_STORE_NAME = '__air_quality__';
  static const String THEME_STORE_NAME = '__theme_store__';
  static const String FAVOURITES_STORE_NAME = '__favourites_store__';
  static const String HEALTH_SITUATION_STORE_NAME =
      '__health_situation_store__';

  final store = intMapStoreFactory.store(AQI_STORE_NAME);
  final themeStore = intMapStoreFactory.store(THEME_STORE_NAME);
  final favouritesStore = intMapStoreFactory.store(FAVOURITES_STORE_NAME);
  final healthSituationStore =
      intMapStoreFactory.store(HEALTH_SITUATION_STORE_NAME);

  Future<Database> get _database async =>
      await PureAirDatabase.instance.database;

  Dao dao = Dao();

  @override
  Future<BaseModel<Aqi>> get fetchModel async {
    var source = await dao.getAqi();
    return source;
  }

  @override
  Future<Aqi> get loadModel async {
    final finder = Finder(sortOrders: [SortOrder("key", false)]);
    final snapshot = await store.find(await _database, finder: finder);

    return snapshot.map((snapshot) {
      final pureAir = Aqi.fromJson(snapshot.value);
      return pureAir;
    }).last;
  }

  @override
  Future saveModel(Aqi model) async {
    await store.add(await _database, model.toJson());
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
  Future<BaseModel<SearchAqi>> searchModel(String city) async {
    var source = await dao.getSearchAqi(city);

    return source;
  }

  @override
  Future<Favourites> get loadFavourites async {
    final finder = Finder(sortOrders: [SortOrder("key", false)]);
    final snapshot =
        await favouritesStore.find(await _database, finder: finder);

    return snapshot.map((snapshot) {
      final favourites = Favourites.fromJson(snapshot.value);
      return favourites;
    }).last;
  }

  @override
  Future saveFavourites(Favourites favourites) async {
    await favouritesStore.add(await _database, favourites.toJson());
  }

  @override
  Future<HealthSituation> get loadSituation async {
    final finder = Finder(sortOrders: [SortOrder("key", false)]);
    final snapshots =
        await healthSituationStore.find(await _database, finder: finder);

    return snapshots.map((snapshot) {
      final healthSituation = HealthSituation.fromJson(snapshot.value);
      return healthSituation;
    }).last;
  }

  @override
  Future saveSituation(HealthSituation situation) async {
    await healthSituationStore.add(await _database, situation.toJson());
  }

  Future deleteFavourite(String id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await favouritesStore.delete(await _database, finder: finder);
  }
}
