import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../models/aqi_by_condition_model.dart';
import '../models/aqi_model.dart';

final store = intMapStoreFactory.store('${env['AQI_STORE']}');

abstract class AqiLocalDataSource {
  /// Gets the stored [AqiModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [DatabaseException] if no cached data is present.
  Future<AqiByConditionModel> getLastAqi();

  Future<void> storeAqi(AqiByConditionModel aqi);
}

class AqiLocalDataSourceImplementation implements AqiLocalDataSource {
  AqiLocalDataSourceImplementation({@required this.database});

  final Database database;

  @override
  Future<AqiByConditionModel> getLastAqi() async {
    final _finder = Finder(sortOrders: [SortOrder('key', true)]);

    final _records = await store.find(database, finder: _finder);

    return _records.isEmpty
        ? null
        : _records.map((record) {
            return AqiByConditionModel.fromJson(record.value);
          }).last;
  }

  @override
  Future<void> storeAqi(AqiByConditionModel aqi) async {
    await store.add(database, aqi.toJson());
  }
}
