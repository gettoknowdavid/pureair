import 'package:auto_size_text/auto_size_text.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/screens/search_details_screen.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/core/search_helper.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/search_textfield.dart';

class PureAirBottomSheet extends StatefulWidget {
  const PureAirBottomSheet({
    Key key,
    @required this.size,
    @required this.close,
  }) : super(key: key);

  final Size size;
  final VoidCallback close;

  @override
  _PureAirBottomSheetState createState() => _PureAirBottomSheetState();
}

class _PureAirBottomSheetState extends State<PureAirBottomSheet> {
  Size get size => MediaQuery.of(context).size;
  TextEditingController textController = TextEditingController();
  SearchBloc get searchBloc => BlocProvider.of<SearchBloc>(context);
  ThemeData get theme => Theme.of(context);

  AutoCompleteTextField searchTextField;
  DbRepository repository = DbRepository();
  List<SearchData> list = [];

  Widget mainCity(SearchAqi searchAqi) {
    final list = searchAqi.data.map((e) => e.aqi).toList();
    bool lessThanTwo = list.length < 1;
    if (lessThanTwo) {
      return Container();
    } else {
      final _list = list..removeWhere((element) => element == '-');
      List<int> aqis = _list.map((e) => int.parse(e)).toList();
      double averageAqi = aqis.fold(0, (p, e) => p + e) / aqis.length;

      SearchHelper searchHelper = SearchHelper(averageAqi.round());
      final searchText = textController.text;
      final city =
          '${searchText[0].toUpperCase()}${searchText.substring(1).toLowerCase()}';

      return Container(
        height: size.shortestSide * 0.3,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 26),
        margin: EdgeInsets.only(top: 12, bottom: 30),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onBackground.withOpacity(0.15),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: size.shortestSide * 0.2,
              width: size.shortestSide * 0.2,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: searchHelper.backgroundColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: AutoSizeText(
                '${averageAqi.round()}',
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: theme.textTheme.headline1.copyWith(
                  // fontSize: 250,
                  fontWeight: FontWeight.w900,
                  color: searchHelper.color,
                ),
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.headline6.copyWith(
                    // color: searchHelper.color,
                    fontSize: 24, fontWeight: FontWeight.w700,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'AVERAGE AIR QUALITY',
                    style: theme.textTheme.subtitle1,
                  ),
                  Text('$city'),
                  Text('From ${aqis.length} stations.'),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          return Container(
            height: widget.size.height,
            width: widget.size.width,
            color: colorScheme.background,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  color: Colors.transparent,
                  child: GestureDetector(
                    child: Text(
                      'CANCEL',
                      style: textTheme.headline6.copyWith(
                        color: colorScheme.secondary,
                        letterSpacing: 3,
                      ),
                    ),
                    onTap: widget.close,
                  ),
                ),
                SearchTaxtField(
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
                Expanded(
                  child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 26),

                    itemCount: state.searchAqi.data.length,
                    itemBuilder: (context, index) {
                      final data = state.searchAqi.data[index];
                      Widget child;
                      if (index == 0) {
                        child = mainCity(state.searchAqi);
                      } else {
                        child = GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              FadePageRoute(
                                widget: SearchDetailsScreen(data: data),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            margin: EdgeInsets.only(bottom: 20),
                            // height: size.shortestSide * 0.1,
                            width: size.width,
                            child: Container(
                              width: size.width * 0.7,
                              child: Text(
                                data.uid.toString(),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.headline6,
                              ),
                            ),
                          ),
                        );
                      }
                      return child;
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: widget.size.height,
            width: widget.size.width,
            color: colorScheme.background,
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  color: Colors.transparent,
                  child: GestureDetector(
                    child: Text(
                      'CANCEL',
                      style: textTheme.headline6.copyWith(
                        color: colorScheme.secondary,
                        letterSpacing: 3,
                      ),
                    ),
                    onTap: widget.close,
                  ),
                ),
                SearchTaxtField(
                  size: size,
                  onPressed: () {},
                  textController: textController,
                ),
                SizedBox(height: 30),
                Container(),
              ],
            ),
          );
        }
      },
    );
  }
}
