import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/screens/search_details_screen.dart';
import 'package:pureair/widgets/fade_page_route.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  TextTheme get textTheme => Theme.of(context).textTheme;
  Size get size => MediaQuery.of(context).size;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  double _panelHeightOpen;
  double _panelHeightClosed = 120.0;

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black12
                        : colorScheme.surface,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: textController,
                    style: textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      suffix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          context
                              .bloc<SearchBloc>()
                              .add(FetchSearch(textController.text));
                          // context.bloc<SearchBloc>().add(LoadSearch());
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 36.0),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchResult) {
                return Container(
                  height: size.height,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[200]
                      : colorScheme.background,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 26, vertical: 12),
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
                );
              } else if (state is SearchLoading) {
                if (textController.text.isEmpty) {
                  return Container();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else if (state is SearchNotFound) {
                return ErrorState(
                  size: size,
                  showRefreshButton: true,
                  errorMessage:
                      'We are sorry, but "${textController.text}" is not a part of our supported stations.',
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[200]
                  : colorScheme.background,
              body: BlocBuilder<SearchBloc, SearchState>(
                bloc: context.bloc<SearchBloc>(),
                builder: (context, state) {
                  if (state is StoredStations) {
                    return ListView.builder(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 26, vertical: 12),
                            margin: EdgeInsets.only(bottom: 20),
                            // height: size.shortestSide * 0.1,
                            width: size.width,
                            // color: Colors.pink,
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
                                  icon: Icon(Icons.remove),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              panelBuilder: (sc) => _panel(sc),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({
    Key key,
    @required this.size,
    this.showRefreshButton = false,
    this.onPressed,
    @required this.errorMessage,
  }) : super(key: key);

  final Size size;
  final bool showRefreshButton;
  final VoidCallback onPressed;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        height: size.shortestSide * 0.4,
        width: size.shortestSide * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 70,
            ),
          ],
        ),
        child: Card(
          elevation: 200,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: showRefreshButton
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: textTheme.headline5.copyWith(),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: onPressed,
                      ),
                    ],
                  )
                : Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: textTheme.headline5.copyWith(),
                  ),
          ),
        ),
      ),
    );
  }
}
