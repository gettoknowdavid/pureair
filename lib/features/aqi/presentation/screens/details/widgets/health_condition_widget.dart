import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/loading_indicator.dart';

import '../../../../../../core/screen_controller/widgets/pollutant_indicator.dart';
import '../../../../../../core/utils/condition_to_string.dart';
import '../../../../../../core/utils/show_condition_list_modal_bottom_sheet.dart';
import '../../../../domain/entities/condition_enum.dart';
import '../../../blocs/aqi_by_condition_bloc.dart';
import '../../../widgets/condition_loaded_or_not.dart';

class HealthConditionWidget extends StatelessWidget {
  const HealthConditionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocBuilder<AqiByConditionBloc, AqiByConditionState>(
        builder: (context, state) {
          if (state is AqiByConditionLoaded) {
            final selectedCondition = state.aqiByCondition.condition;

            return selectedCondition == ConditionEnum.none
                ? ConditionLoadedOrNot(
                    onTap: () => showConditionListModalBottomSheet(context),
                  )
                : _buildLoaded(context, state);
          } else if (state is AqiByConditionLoading) {
            return LoadingIndicator(width: height * 0.08, height: height* 0.08,);
          } else {
            return ConditionLoadedOrNot(
              onTap: () => showConditionListModalBottomSheet(context),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, AqiByConditionLoaded state) {
    final theme = Theme.of(context);

    return ConditionLoadedOrNot(
      onTap: () => showConditionListModalBottomSheet(context),
      title: conditionToString(state.aqiByCondition.condition),
      child: Column(
        children: [
          Text(
            state.aqiByCondition.message,
            style: theme.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          _buildPollutants(state.aqiByCondition.pollutants),
        ],
      ),
    );
  }

  GridView _buildPollutants(List<Map<String, String>> pollutants) {
    int crossAxisCount = pollutants.length < 5 ? pollutants.length : 4;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: pollutants.length < 5 ? 0 : 20,
        crossAxisSpacing: 25,
      ),
      itemCount: pollutants.length,
      itemBuilder: (context, index) {
        final pollutant = pollutants[index];
        final _index = pollutant.values.elementAt(0);
        final _title = pollutant.keys.elementAt(0);

        return PollutantIndicator(
          pollutantIndex: _index == '-' ? 0 : int.parse(_index),
          pollutantTitle: _title,
        );
      },
    );
  }
}
