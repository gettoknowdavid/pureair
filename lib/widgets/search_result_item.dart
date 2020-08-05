import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pureair/screens/search_details_screen.dart';
import 'package:pureair/src/core/search_helper.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/date_formatter.dart';
import 'package:pureair/widgets/fade_page_route.dart';

class SearchResultItem extends StatefulWidget {
  const SearchResultItem({
    Key key,
    @required this.size,
    @required this.searchData,
    this.isFavourite,
    this.onFavourite,
  }) : super(key: key);

  final Size size;
  final SearchData searchData;
  final bool isFavourite;
  final VoidCallback onFavourite;

  @override
  _SearchResultItemState createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final mainContainerHeight = widget.size.shortestSide * 0.2;
    final mainContainerWidth = widget.size.width;
    final mainRadius = mainContainerHeight * 0.2;

    final aqiSize = mainContainerHeight * 0.6;
    final radius = aqiSize * 0.24;

    final aqi =
        widget.searchData.aqi.contains('-') || widget.searchData.aqi == null
            ? '0'
            : widget.searchData.aqi;
    final SearchHelper helper = SearchHelper(int.parse(aqi));

    return GestureDetector(
      onTap: () => int.parse(aqi) == 0
          ? null
          : Navigator.push(
              context,
              FadePageRoute(
                widget: SearchDetailsScreen(data: widget.searchData),
              ),
            ),
      child: Container(
        height: mainContainerHeight,
        width: mainContainerWidth,
        margin: EdgeInsets.only(top: 26),
        child: Material(
          elevation: 12,
          shadowColor: Colors.black38,
          color: theme.brightness == Brightness.light
              ? Colors.white
              : theme.primaryColor,
          borderRadius: BorderRadius.circular(mainRadius),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  height: aqiSize,
                  width: aqiSize,
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: int.parse(aqi) == 0
                        ? colorScheme.background
                        : helper.backgroundColor,
                  ),
                  child: AutoSizeText(
                    int.parse(aqi) == 0 ? '-' : aqi,
                    maxLines: 1,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline1.copyWith(
                      fontWeight: FontWeight.w900,
                      color: int.parse(aqi) == 0
                          ? colorScheme.onBackground
                          : helper.color,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: DefaultTextStyle(
                      style: textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'STATION',
                            style: textTheme.subtitle2.copyWith(
                              letterSpacing: 2,
                              // fontSize: 18,
                              color: colorScheme.onBackground.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            widget.searchData.station.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          SizedBox(height: 6),
                          Text(
                            dateFormat(widget.searchData.time.stime),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: textTheme.subtitle2.copyWith(
                              letterSpacing: 2,
                              // fontSize: 18,
                              color: colorScheme.onBackground.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: widget.onFavourite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
