import 'package:flutter/material.dart';

import '../../../../core/utils/condition_to_string.dart';
import '../../../../core/utils/show_condition_list_modal_bottom_sheet.dart';
import '../../domain/entities/aqi_by_condition.dart';
import '../../domain/entities/condition_enum.dart';
import '../screens/details/widgets/detail_card.dart';
import 'gradient_condition_button.dart';

class AqiScreenConditionWidget extends StatefulWidget {
  const AqiScreenConditionWidget({Key key, @required this.aqiByCondition})
      : super(key: key);
  final AqiByCondition aqiByCondition;

  @override
  _AqiScreenConditionWidgetState createState() =>
      _AqiScreenConditionWidgetState();
}

class _AqiScreenConditionWidgetState extends State<AqiScreenConditionWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
        borderRadius: BorderRadius.circular(26),
        color: const Color(0xFF131313),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final setCondition = widget.aqiByCondition.condition;
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final mainHeight = height * 0.1;
    final mainWidth = width * 0.87;
    bool isNone = setCondition == ConditionEnum.none;
    if (!isNone) {
      return InkWell(
        onTap: () {
          !isNone ? null : showConditionListModalBottomSheet(context);
          setState(() => isOpen = (isNone ? false : !isOpen));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isOpen ? mainHeight * 1.7 : mainHeight,
          width: mainWidth,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
          alignment: Alignment.center,
          child: _buildConditionLoaded(context, widget.aqiByCondition, isOpen),
        ),
      );
    } else {
      return _buildNoConditionText(theme);
    }
  }

  Widget _buildConditionLoaded(
      BuildContext context, AqiByCondition aqiByCondition, bool isOpen) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GradientConditionButton(
              title: conditionToString(aqiByCondition.condition),
              height: height * 0.04,
              onTap: () => showConditionListModalBottomSheet(context),
            ),
            SizedBox(height: 6),
            Text(
              aqiByCondition.message,
              maxLines: isOpen ? 4 : 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNoConditionText(ThemeData theme) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => showConditionListModalBottomSheet(context),
      child: DetailCard(
        width: width * 0.87,
        borderRadius: 18,
        child: Text(
          'No health condition set. Tap to set now',
          textAlign: TextAlign.center,
          style: theme.textTheme.subtitle2.copyWith(
            fontSize: 16,
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
