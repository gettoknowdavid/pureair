import 'package:auto_size_text/auto_size_text.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/screens/search_details_screen.dart';
import 'package:pureair/src/core/aqi_helper.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/search_helper.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/date_formatter.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/pureair_app_bar.dart';
import 'package:pureair/widgets/pureair_expansion_tile.dart';
import 'package:pureair/widgets/search_textfield.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Size get size => MediaQuery.of(context).size;
  TextEditingController textController = TextEditingController();
  SearchBloc get searchBloc => BlocProvider.of<SearchBloc>(context);
  ThemeData get theme => Theme.of(context);

  AutoCompleteTextField searchTextField;
  DbRepository repository = DbRepository();
  List<SearchData> list = [];

  final GlobalKey<PureAirExpansionTileState> expansionTile = new GlobalKey();

  @override
  void initState() {
    super.initState();
    searchBloc.add(ClearSearch());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: Color(0xFFF2F2F2),
     
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoaded) {
            final totalNumberOfStations = state.searchAqi.data.length;
            print(totalNumberOfStations);

            final numberOfInactiveStations =
                state.searchAqi.data.where((e) => e.aqi.contains('-')).length;
            print(numberOfInactiveStations);

            final numberOfActiveStations =
                totalNumberOfStations - numberOfInactiveStations;
            print(numberOfActiveStations);

            return Container(
              height: size.height,
              width: size.width,
              // color: colorScheme.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SearchTaxtField(
                    scaffoldKey: _scaffoldKey,
                    size: size,
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    onPressed: () {
                      context
                          .bloc<SearchBloc>()
                          .add(SearchCity(textController.text));
                    },
                    textController: textController,
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.fromLTRB(26, 6, 26, 16),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Select a station...',
                            style: textTheme.headline5,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: AutoSizeText(
                            state.searchAqi.data.length.toString(),
                            style: textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(26, 0, 26, 26),
                      itemCount: state.searchAqi.data.length,
                      itemBuilder: (context, index) {
                        final data = state.searchAqi.data[index];
                        final selectedIndex =
                            state.searchAqi.data.indexOf(data);

                        bool ooo = index == selectedIndex;

                        return SearchResultItem(
                          size: size,
                          searchData: data,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: size.height,
              width: size.width,
              color: colorScheme.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      'Search your \nfavourite cities',
                      style: textTheme.headline3,
                    ),
                  ),
                  SizedBox(height: 30),
                  SearchTaxtField(
                    scaffoldKey: _scaffoldKey,
                    size: size,
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    onPressed: () {},
                    textController: textController,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class SearchResultItem extends StatefulWidget {
  const SearchResultItem({
    Key key,
    @required this.size,
    @required this.searchData,
  }) : super(key: key);

  final Size size;
  final SearchData searchData;

  @override
  _SearchResultItemState createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  bool _isExpanded = false;

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
        widget.searchData.aqi.contains('-') ? '0' : widget.searchData.aqi;
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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        margin: EdgeInsets.only(top: 26),
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(mainRadius),
          boxShadow: [
            if (int.parse(aqi) != 0)
              BoxShadow(
                color: theme.colorScheme.onBackground.withOpacity(0.13),
                blurRadius: 17,
              ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: aqiSize,
              width: aqiSize,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: int.parse(aqi) == 0
                    ? colorScheme.background
                    : helper.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onBackground.withOpacity(0.1),
                    blurRadius: 17,
                  ),
                ],
                borderRadius: BorderRadius.circular(radius),
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
                height: aqiSize,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: DefaultTextStyle(
                  style: textTheme.headline6.copyWith(
                    // color: searchHelper.color,
                    fontWeight: FontWeight.w700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
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
