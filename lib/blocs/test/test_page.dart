import 'package:flutter/material.dart';
import 'package:pureair/blocs/test/index.dart';

class TestPage extends StatefulWidget {
  static const String routeName = '/test';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _testBloc = TestBloc(UnTestState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: TestScreen(testBloc: _testBloc),
    );
  }
}
