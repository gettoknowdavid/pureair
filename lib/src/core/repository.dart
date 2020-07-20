import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/pure_air_theme.dart';
import 'package:pureair/src/model/pureair.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';

abstract class Repository {
  Future<Aqi> get fetchModel;
  Future<PureAir> get fetchPureAir;

  Future<SearchAqi> searchModel(String city);

  Future<Aqi> get loadModel;
  Future saveModel(Aqi model);
  Future get clearAqiStore;


  Future<PureAir> get loadPureAir;
  Future savePureAir(PureAir pureAir);

  Future<PureAirTheme> get loadTheme;
  Future saveTheme(PureAirTheme theme);
  Future get clearThemeStore;
}
