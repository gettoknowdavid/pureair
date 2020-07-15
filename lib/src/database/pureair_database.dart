import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PureAirDatabase {
  static final PureAirDatabase _singleton = PureAirDatabase._();

  static PureAirDatabase get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  PureAirDatabase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    await dir.create(recursive: true);

    final dbPath = join(dir.path, 'air_ng.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter.complete(database);
  }
}
