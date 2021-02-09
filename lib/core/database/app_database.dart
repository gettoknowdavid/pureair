import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static Future initialize() async => await _initDatabase();

  static Future _initDatabase() async {
    final _dir = await getApplicationDocumentsDirectory();

    await _dir.create(recursive: true);

    final _path = join(_dir.path, '${env['DATABASE_NAME']}');

    final _database = await databaseFactoryIo.openDatabase(_path);

    GetIt.I.registerSingleton<Database>(_database);
  }
}
