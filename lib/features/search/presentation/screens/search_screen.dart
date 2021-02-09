import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../blocs/search_aqi/search_aqi_bloc.dart';
import '../widgets/search_result_list.dart';
import '../widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    TextEditingController textController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocListener<SearchAqiBloc, SearchAqiState>(
          listenWhen: (previous, current) {
            return true;
          },
          listener: (context, state) {
            if (state is SearchAqiLoaded) {
              if (state.searchAqi.data.length < 1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ErrorDialog(
                      message:
                          'No stations available in this location. Try again.',
                    );
                  },
                );
              }
            }
          },
          child: BlocBuilder<SearchAqiBloc, SearchAqiState>(
            builder: (context, state) {
              if (state is SearchAqiLoaded) {
                return SingleChildScrollView(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SearchWidget(
                        scaffoldKey: _scaffoldKey,
                        textController: textController,
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        child: SearchResultList(searchAqi: state.searchAqi),
                      ),
                    ],
                  ),
                );
              } else if (state is SearchAqiEmpty) {
                return SearchWidget(
                  scaffoldKey: _scaffoldKey,
                  textController: textController,
                );
              } else {
                return LoadingIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
