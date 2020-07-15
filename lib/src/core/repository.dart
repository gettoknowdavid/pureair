import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/src/model/search_model/search.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

abstract class Repository {
  Future<Aqi> get fetchModel;

  Future<SearchAqi> searchModel(String city);
  Future<Search> get loadSearchModel;
  Future saveSearchModel(Search search);

  Future<Aqi> get loadModel;
  Future saveModel(Aqi model);

  Future<PureAirTheme> get loadTheme;
  Future saveTheme(PureAirTheme theme);
  Future get clearThemeStore;
}
