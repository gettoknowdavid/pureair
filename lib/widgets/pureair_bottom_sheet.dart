import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/screens/search_details_screen.dart';
import 'package:pureair/screens/search_screen.dart';
import 'package:pureair/src/core/db_repository.dart';
import 'package:pureair/src/model/aqi.dart';
import 'package:pureair/src/model/search_model/search_aqi.dart';
import 'package:pureair/src/model/search_model/search_data.dart';
import 'package:pureair/widgets/country_list.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:pureair/widgets/loading_indicator.dart';

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
  GlobalKey<AutoCompleteTextFieldState<SearchCountry>> _textFieldKey =
      GlobalKey();
  Size get size => MediaQuery.of(context).size;
  TextEditingController textController = TextEditingController();
  SearchBloc get searchBloc => BlocProvider.of<SearchBloc>(context);

  AutoCompleteTextField searchTextField;
  DbRepository repository = DbRepository();
  List<SearchData> list = [];
  
  Future<List<SearchData>> _getStations(String city) async {
    SearchAqi searchedCity = await repository.searchModel(city);
    final _list = list..addAll(searchedCity.data);
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is StoredStations) {
          return Container();
        }
        if (state is SearchResult) {
          return Container(
            height: widget.size.height,
            width: widget.size.width,
            color: theme.brightness == Brightness.light
                ? colorScheme.onPrimary
                : colorScheme.background,
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  color: Colors.transparent,
                  child: GestureDetector(
                    child: Text('CANCEL', style: textTheme.headline6),
                    onTap: widget.close,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black12
                          : colorScheme.surface,
                    ),
                    // padding: EdgeInsets.only(left: 26),
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            focusNode: FocusNode(),
                            autofocus: true,
                            controller: textController,
                            style: textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: 'Search s city',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          color: theme.brightness == Brightness.light
                              ? Colors.black45
                              : Colors.white54,
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              searchBloc.add(FetchSearch(textController.text));
                            },
                            iconSize: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.stations.length,
                    itemBuilder: (context, index) {
                      final data = state.stations[index];
                      final station = state.stations[index].station;
                      return GestureDetector(
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
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_city),
                              SizedBox(width: 5),
                              Container(
                                width: size.width * 0.7,
                                child: Text(
                                  station.name,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headline6,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  context
                                      .bloc<SearchBloc>()
                                      .add(AddStation(data));
                                  context.bloc<SearchBloc>()
                                    ..add(LoadStationData());
                                  // context.bloc<SearchBloc>().add(LoadSearch());
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is SearchLoading) {
          if (textController.text.isEmpty) {
            return Container();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        } else {
          return ErrorState(
            size: size,
            showRefreshButton: true,
            errorMessage:
                'We are sorry, but "${textController.text}" is not a part of our supported stations.',
          );
        }
      },
    );
  }
}
