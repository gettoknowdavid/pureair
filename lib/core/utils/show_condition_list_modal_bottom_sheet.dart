import 'package:flutter/material.dart';
import '../../features/aqi/domain/entities/condition_enum.dart';
import '../../features/aqi/presentation/widgets/condition_title.dart';

Future<dynamic> showConditionListModalBottomSheet(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final theme = Theme.of(context);

  _conditionList() {
    List<Widget> _conditionList = [];

    for (ConditionEnum condition in ConditionEnum.values) {
      _conditionList.add(ConditionListTile(condition: condition));
    }
    return _conditionList;
  }

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: height * 0.5,
        color: theme.colorScheme.surface,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _conditionList(),
        ),
      );
    },
  );
}
