import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';
import 'package:pureair/screens/search_details_screen.dart';
import 'package:pureair/src/core/db_repository.dart';
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

  AutoCompleteTextField searchTextField;
  DbRepository repository = DbRepository();
  List<SearchData> list = [];

  Widget mainCity(SearchAqi searchAqi) {
    List<int> averageAqi = searchAqi.data.map((e) => int.parse(e.aqi)).toList();
    double avg = averageAqi.fold(0, (p, e) => p + e) / averageAqi.length;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text('${textController.text}'), Text('$avg')],
      ),
    );
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
                SearchTaxtField(
                  size: size,
                  onPressed: () {
                    print('hey');
                    context
                        .bloc<SearchBloc>()
                        .add(SearchCity(textController.text));
                  },
                  textController: textController,
                ),
                SizedBox(height: 30),
                mainCity(state.searchAqi),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.searchAqi.data.length,
                    itemBuilder: (context, index) {
                      final data = state.searchAqi.data[index];

                      print(data);
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
