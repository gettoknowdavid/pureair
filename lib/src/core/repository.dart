import 'package:pureair/src/core/base_model.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/src/model/search_model/favourites.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

abstract class Repository {
  Future<BaseModel<Aqi>> get fetchModel;

  Future<HealthSituation> get loadSituation;

  Future saveSituation(HealthSituation situation);

  Future<BaseModel<SearchAqi>> searchModel(String city);

  Future<Aqi> get loadModel;
  Future saveModel(Aqi model);

  Future<Favourites> get loadFavourites;
  Future saveFavourites(Favourites favourites);

  Future<PureAirTheme> get loadTheme;
  Future saveTheme(PureAirTheme theme);
  Future get clearThemeStore;
}
