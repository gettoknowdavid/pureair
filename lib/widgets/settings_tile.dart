
import 'package:flutter/material.dart';
class SettingsTile extends StatelessWidget {
  const SettingsTile({
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
      size: 30,
      color:
          enabled ? colorScheme.primary : colorScheme.primary.withOpacity(0.2),
    );

    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: textTheme.headline5.copyWith(
            fontWeight: FontWeight.w600,
            color: enabled
                ? colorScheme.onBackground
                : colorScheme.onBackground.withOpacity(0.3),
          ),
        ),
        enabled: enabled ?? false,
        contentPadding: contentPadding,
        trailing: trailingIcon,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ),
          );
        },
      ),
    );
  }
}
