import 'package:flutter/material.dart';
import '../../../../core/widgets/fade_page_route.dart';

class SettingsSubTile extends StatelessWidget {
  const SettingsSubTile({
    Key key,
    this.enabled: false,
    @required this.title,
    this.widget,
  }) : super(key: key);

  final bool enabled;
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final contentPadding = EdgeInsets.zero;

    final trailingIcon = Icon(
      Icons.chevron_right,
      color:
          enabled ? colorScheme.primary : colorScheme.primary.withOpacity(0.2),
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          title: Text(
            title,
            style: textTheme.headline6.copyWith(
              color: enabled
                  ? colorScheme.onBackground
                  : colorScheme.onBackground.withOpacity(0.3),
            ),
          ),
          enabled: enabled ?? false,
          contentPadding: contentPadding,
          trailing: trailingIcon,
          onTap: () {
            Navigator.of(context).push(FadePageRoute(widget: widget));
          },
        ),
      ),
    );
  }
}
