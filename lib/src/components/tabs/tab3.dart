import 'package:flutter/material.dart';

class Tab3 extends StatelessWidget {
  final PageStorageBucket bucket;

  Tab3({Key key, @required this.bucket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Tab 3",
              style: new TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
