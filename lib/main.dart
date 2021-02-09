import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dependency_injector.dart' as di;
import 'run_pureair_app.dart';

Future<void> main() async {
  await load(fileName: '.env');
  await di.initialize();

  runPureAirApp();
}

