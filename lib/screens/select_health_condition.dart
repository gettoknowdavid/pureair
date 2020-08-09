import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/situation/situation_bloc.dart';
import 'package:pureair/src/model/health_situation.dart';
import 'package:pureair/widgets/custom_back_button.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';

class SelectHealthCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listTilePadding = EdgeInsets.symmetric(vertical: 6);

    Widget _buildListTile(SituationEnum situation,
        {bool isSelected: false, VoidCallback onTap}) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(
              enumToString(situation),
              style: textTheme.headline5.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onBackground,
              ),
            ),
            contentPadding: listTilePadding,
            trailing: isSelected
                ? Icon(
                    Icons.check,
                    color: colorScheme.primary,
                  )
                : null,
            onTap: onTap,
          ),
          Divider(),
        ],
      );
    }

    return BlocBuilder<SituationBloc, SituationState>(
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: PureAirAppBar(leading: PureAirBackButton()),
            body: BlocBuilder<SituationBloc, SituationState>(
              builder: (context, state) {
                if (state is SituationLoaded) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: SituationEnum.values.length,
                    itemBuilder: (context, index) {
                      return _buildListTile(
                        SituationEnum.values[index],
                        isSelected: SituationEnum.values[index].index ==
                            state.situation.index,
                        onTap: () {
                          print(SituationEnum.values[index]);
                          context.bloc<SituationBloc>().add(
                              UpdateSituation(SituationEnum.values[index]));
                        },
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: SituationEnum.values.length,
                    itemBuilder: (context, index) {
                      return _buildListTile(
                        SituationEnum.values[index],
                        isSelected: SituationEnum.values[index].index == 0,
                      );
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

String enumToString(dynamic input) {
  String name = input.toString().split('.').last;
  // String firstLetter = name[0].toUpperCase();
  // final otherLetters = name.split(name[0]);
  if (name == 'asthma')
    return 'Asthma';
  else if (name == 'bronchitis')
    return 'Bronchitis';
  else if (name == 'emphysema')
    return 'Emphysema';
  else if (name == 'lungCancer')
    return 'Lung Cancer';
  else if (name == 'hbp')
    return 'High Blood Pressure';
  else
    return 'None';
}
// String enumFormatter(dynamic input) {
//   final name = enumToString(input);
//   if ()
// }
