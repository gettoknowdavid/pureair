import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pureair/blocs/search/search_bloc.dart';

class SearchTaxtField extends StatelessWidget {
  const SearchTaxtField({
    Key key,
    @required this.size,
     this.onPressed,
    @required this.textController,
  }) : super(key: key);

  final Size size;
  final VoidCallback onPressed;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ClipRRect(
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
                  hintText: 'Search a city',
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                    context.bloc<SearchBloc>()
                      ..add(SearchCity(textController.text));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: theme.brightness == Brightness.light
                    ? Colors.black45
                    : Colors.white54,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
