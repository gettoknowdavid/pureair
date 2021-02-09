import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/condition_to_string.dart';
import '../../domain/entities/condition_enum.dart';
import '../blocs/aqi_by_condition_bloc.dart';

class ConditionListTile extends StatelessWidget {
  const ConditionListTile({Key key, @required this.condition})
      : super(key: key);

  final ConditionEnum condition;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    // ignore: close_sinks
    final bloc = context.read<AqiByConditionBloc>();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(26, 0, 26, 0),
        child: Material(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              bloc..add(UpdateAqiByCondition(condition: condition));
              Navigator.pop(context);
            },
            child: Container(
              height: height * 0.065,
              padding: EdgeInsets.fromLTRB(26, 0, 26, 0),
              alignment: Alignment.center,
              child: Text(
                conditionToString(condition),
                style: theme.textTheme.headline6.copyWith(
                  fontWeight: FontWeight.normal,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
