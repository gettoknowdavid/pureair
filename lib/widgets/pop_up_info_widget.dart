import 'package:flutter/material.dart';

class PopUpInfoWidget extends StatelessWidget {
  const PopUpInfoWidget({
    Key key,
    @required this.size,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    String _title() {
      switch (title) {
        case 'CO':
          return 'Carbon monoxide';
        case 'O\u2083':
          return 'Ground level ozone';

        case 'NO\u2082':
          return 'Nitrogen dioxide';
        case 'PM10':
          return 'Particulate matter';
        case 'PM2.5':
          return 'Particulate matter';
        default:
          return 'Sodium dioxide';
      }
    }

    return Center(
      child: Container(
        height: size.height * 0.4,
        width: size.width * 0.95,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _title(),
                  style: textTheme.headline4.copyWith(
                    color: colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
