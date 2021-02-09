import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/condition_to_string.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../aqi/domain/entities/condition_enum.dart';
import '../../../aqi/presentation/blocs/aqi_by_condition_bloc.dart';

class SelectCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conditions = ConditionEnum.values;
    // ignore: close_sinks
    final cubit = context.read<AqiByConditionBloc>();

    _onTap(int index) {
      cubit..add(UpdateAqiByCondition(condition: ConditionEnum.values[index]));
      Navigator.pop(context);
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBar(leading: CustomBackButton()),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24),
          itemCount: ConditionEnum.values.length,
          itemBuilder: (context, index) {
            return BlocBuilder<AqiByConditionBloc, AqiByConditionState>(
              builder: (context, state) {
                if (state is AqiByConditionLoaded) {
                  final condition = state.aqiByCondition.condition;

                  return _ListTile(
                    title: conditionToString(conditions[index]),
                    isSelected: conditions[index].index == condition.index,
                    onTap: () => _onTap(index),
                  );
                } else {
                  return _ListTile(
                    title: conditionToString(conditions[index]),
                    isSelected: ConditionEnum.values[index].index == 0,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ListTile({
    Key key,
    @required this.title,
    @required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listTilePadding = EdgeInsets.symmetric(
      vertical: 6,
      horizontal: 16,
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: textTheme.headline6.copyWith(
                color: colorScheme.onBackground,
                fontWeight: FontWeight.normal,
              ),
            ),
            contentPadding: listTilePadding,
            trailing: !isSelected
                ? null
                : Icon(Icons.check, color: colorScheme.primary),
            onTap: onTap,
          ),
          Divider(),
        ],
      ),
    );
  }
}
