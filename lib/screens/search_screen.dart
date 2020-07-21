import 'package:auto_size_text/auto_size_text.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/loading_indicator.dart';
import 'package:pureair/widgets/pureair_expansion_tile.dart';
import 'package:pureair/widgets/search_result_item.dart';
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
      // backgroundColor: Color(0xFFF2F2F2),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoaded) {
            return Container(
              height: size.height,
              width: size.width,
              // color: colorScheme.background,
              margin: EdgeInsets.only(top: 26),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  SearchTaxtField(
                    scaffoldKey: _scaffoldKey,
                    size: size,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    textController: textController,
                  ),
                  SizedBox(height: 30),
                  state.searchAqi.data.length < 1
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(16, 6, 16, 16),
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
                                  color: colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: AutoSizeText(
                                  state.searchAqi.data.length.toString(),
                                  style: textTheme.headline6.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  state.searchAqi.data.length < 1
                      ? Container(
                          width: size.width,
                          padding: EdgeInsets.all(26),
                          alignment: Alignment.center,
                          child: Text(
                            'Sorry, there are no stations available in this location. \nTry again.',
                            textAlign: TextAlign.center,
                            style: textTheme.headline5,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 26),
                            itemCount: state.searchAqi.data.length,
                            itemBuilder: (context, index) {
                              final data = state.searchAqi.data[index];

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
          } else if (state is SearchLoading) {
            return LoadingIndicator(size: size);
          } else {
            return SearchWidget(
              size: size,
              scaffoldKey: _scaffoldKey,
              textController: textController,
            );
          }
        },
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
    @required this.size,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required this.textController,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final Size size;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: size.height,
      width: size.width,
      // color: Color(0xFFF2F2F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Search your \nfavourite cities',
              style: textTheme.headline3,
            ),
          ),
          SizedBox(height: 30),
          SearchTaxtField(
            scaffoldKey: _scaffoldKey,
            size: size,
            margin: EdgeInsets.symmetric(horizontal: 16),
            textController: textController,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
