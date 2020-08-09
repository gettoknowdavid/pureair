import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/model/data.dart';

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({
    Key key,
    this.size,
    this.data,
    this.onTap,
    this.showRemoveButtons,
    this.remove,
    this.flagged,
    AqiHelper helper,
  })  : _helper = helper,
        super(key: key);

  final Size size;
  final Data data;
  final VoidCallback onTap;
  final bool showRemoveButtons;
  final VoidCallback remove;
  final AqiHelper _helper;
  final bool flagged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final mainContainerHeight = size.height * 0.2;
    final aqiContainerSize = mainContainerHeight * 0.5;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mainContainerHeight,
        width: size.width,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Stack(
          children: <Widget>[
            Material(
              elevation: 20,
              shadowColor: Colors.black26,
              color: theme.brightness == Brightness.light
                  ? Colors.white
                  : colorScheme.background,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data != null ? data.city.name : 'Sorry no city',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline4,
                          ),
                          SizedBox(height: 10),
                          Text(
                            data != null
                                ? _helper.healthConcern
                                : 'Okay, the air is...empty!',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline6,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                'DOMINANT POLLUTANT: ',
                                style: textTheme.subtitle1.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                  color: textTheme.subtitle1.color
                                      .withOpacity(0.7),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 30,
                                width: 50,
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: AutoSizeText(
                                  _helper.dominantPol,
                                  style: textTheme.headline6.copyWith(
                                    color: colorScheme.onSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: aqiContainerSize,
                      width: aqiContainerSize,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(right: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: data != null
                            ? _helper.backgroundColor
                            : colorScheme.background,
                      ),
                      child: AutoSizeText(
                        data != null ? data.aqi.toString() : '-',
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: textTheme.headline1.copyWith(
                          fontWeight: FontWeight.w900,
                          color: data != null
                              ? _helper.color
                              : colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Row(
                  children: <Widget>[
                    Text(flagged ? 'Flagged City' : 'Safe City'),
                    Icon(
                      flagged ? Icons.flag : Icons.check,
                      color: colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
            showRemoveButtons
                ? Container()
                : Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: remove,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
