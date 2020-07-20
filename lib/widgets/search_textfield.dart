import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';

class SearchTaxtField extends StatelessWidget {
  const SearchTaxtField({
    Key key,
    @required this.size,
    this.margin,
    this.onPressed,
    @required this.textController,
    this.scaffoldKey,
  }) : super(key: key);

  final Size size;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final EdgeInsets margin;

  final VoidCallback onPressed;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: colorScheme.onBackground.withOpacity(0.3),
          ),
          // padding: EdgeInsets.only(left: 26),
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    focusNode: FocusNode(),
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    controller: textController,
                    style: textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      // errorText: validateText(textController.text),
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Search a city',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (textController.text == null ||
                      textController.text.isEmpty) {
                    scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        elevation: 0,
                        content: ErrorSnackBar(
                          size: size,
                          text:
                              'Oops, looks like you forgot to type in a city.',
                        ),
                      ),
                    );
                  } else if (textController.text.length < 2) {
                    scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        elevation: 0,
                        content: ErrorSnackBar(
                          size: size,
                          text: 'Urrhm, thats not a city name.',
                        ),
                      ),
                    );
                  } else {
                    context
                        .bloc<SearchBloc>()
                        .add(SearchCity(textController.text));
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: colorScheme.onBackground,
                  child: Icon(
                    Icons.search,
                    color: colorScheme.surface,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorSnackBar extends StatelessWidget {
  const ErrorSnackBar({
    Key key,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: size.shortestSide * 0.2,
      width: size.width,
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.92,
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: colorScheme.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          text,
          style: textTheme.headline6.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
