import 'package:flutter/material.dart';

import 'search_text_field.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required this.textController,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      width: size.width,
      padding: EdgeInsets.only(bottom: 12, top: 18),
      alignment: Alignment.bottomCenter,
      child: SearchTextField(
        textController: textController,
        scaffoldKey: _scaffoldKey,
        margin: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
