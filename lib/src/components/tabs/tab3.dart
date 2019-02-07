import 'package:flutter/material.dart';

class Tab3 extends StatelessWidget {
  final PageStorageBucket bucket;

  Tab3({Key key, @required this.bucket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Tab 3",
                style: new TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
