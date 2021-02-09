import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/core/network/network_info.dart';
import 'package:pureair/core/widgets/check_connection_widget.dart';

import '../blocs/search_aqi/search_aqi_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key key,
    this.margin,
    @required this.textController,
    this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final EdgeInsets margin;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    DataConnectionChecker connCheck = DataConnectionChecker();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    showSnackBar(String message) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        elevation: 300,
        builder: (context) => CheckConnectionWidget(message: message),
      );
    }

    String _validator(city) {
      if (city == null || city.isEmpty) {
        showSnackBar('Oops, looks like you forgot to type in a city.');
      } else if (city.length < 2) {
        showSnackBar('Urrhm, thats not a city name. Try again');
      }
      return null;
    }

    _search(String city) async {
      if (_formKey.currentState.validate()) {
        if (await connCheck.hasConnection) {
          context.read<SearchAqiBloc>()..add(SearchCityEvent(city: city));
          FocusManager.instance.primaryFocus.unfocus();
        } else {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isDismissible: true,
            elevation: 300,
            builder: (context) => CheckConnectionWidget(),
          );
        }
      }
    }

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          width: size.width,
          color: colorScheme.onBackground.withOpacity(0.1),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    controller: textController,
                    style: textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 19,
                    ),
                    validator: (city) => _validator(city),
                    onFieldSubmitted: (city) => _search(city),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'Search a city',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _search(textController.text),
                child: _buildSearchButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          stops: [0.3, 1.0],
          begin: Alignment.topLeft,
        ),
      ),
      child: Icon(Icons.search),
    );
  }
}
