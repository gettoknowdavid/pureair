import 'package:flutter/material.dart';
import 'package:pureair/run_pureair.dart';
import 'package:pureair/src/core/db_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbRepository repository = DbRepository();
  

  runPureAir(repository);
}
