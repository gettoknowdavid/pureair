import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  TextTheme get textTheme => Theme.of(context).textTheme;
  Size get size => MediaQuery.of(context).size;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;


 

  @override
  Widget build(BuildContext context) {

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            
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
