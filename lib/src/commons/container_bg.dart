import 'package:flutter/material.dart';

class ContainerBg extends StatelessWidget {
  final Widget child;

  const ContainerBg({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage('lib/assets/bg/login_bg.jpg'),
            fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
