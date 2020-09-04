import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/test/index.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({
    Key key,
    @required TestBloc testBloc,
  })  : _testBloc = testBloc,
        super(key: key);

  final TestBloc _testBloc;

  @override
  TestScreenState createState() {
    return TestScreenState();
  }
}

class TestScreenState extends State<TestScreen> {
  TestScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
        cubit: widget._testBloc,
        builder: (
          BuildContext context,
          TestState currentState,
        ) {
          if (currentState is UnTestState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorTestState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InTestState) {
            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text(currentState.aqi.data.city.name),
            //     ],
            //   ),
            // );
            return Center(
              child: ListView.builder(
                itemCount: currentState.aqi.length,
                itemBuilder: (context, index) {
                  return Text(currentState.aqi[index].data.city.name);
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._testBloc.add(LoadTestEvent());
  }
}
