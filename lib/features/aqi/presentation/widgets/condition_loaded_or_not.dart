import 'package:flutter/material.dart';

import '../screens/details/widgets/detail_card.dart';
import 'gradient_condition_button.dart';

class ConditionLoadedOrNot extends StatelessWidget {
  const ConditionLoadedOrNot({Key key, this.title, this.child, this.onTap})
      : super(key: key);

  final String title;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DetailCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('HEALTH CONDITION'),
            SizedBox(height: 12),
            GradientConditionButton(
              title: title ?? 'Tap to select a health condition',
              onTap: onTap,
              height: height * 0.045,
            ),
            SizedBox(height: 20),
            child ?? _buildChild(theme),
          ],
        ),
      ),
    );
  }

  Text _buildChild(ThemeData theme) {
    return Text(
      'Select your preferred health condition to see air pollutants tailored to your health situation.',
      style: theme.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.normal,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}
