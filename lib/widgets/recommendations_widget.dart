import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/aqi.dart';

class RecommendationsList extends StatefulWidget {
  const RecommendationsList({
    Key key,
    @required this.model,
    @required this.size,
  }) : super(key: key);

  final Aqi model;
  final Size size;

  @override
  _RecommendationsListState createState() => _RecommendationsListState();
}

class _RecommendationsListState extends State<RecommendationsList> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final helper = AqiHelper(widget.model);
    final containerSize = widget.size.shortestSide * 0.16;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: helper.healthRec.map(
        (e) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Container(
                    height: widget.size.shortestSide * 0.3,
                    width: widget.size.width,
                    padding: EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 30.0),
                          height: 60,
                          width: 60,
                          child: ImageIcon(
                            AssetImage(e.keys.elementAt(0)),
                            color: helper.backgroundColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            e.values.elementAt(0),
                            softWrap: true,
                            maxLines: 4,
                            style: textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              height: containerSize,
              width: containerSize,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: helper.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: helper.color.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onBackground.withOpacity(0.1),
                    blurRadius: 14,
                  ),
                ],
              ),
              child: Container(
                height: containerSize,
                width: containerSize,
                padding: EdgeInsets.all(6),
                child: ImageIcon(
                  AssetImage(e.keys.elementAt(0)),
                  color: helper.color,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
