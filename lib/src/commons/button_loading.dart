import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  final bool isLoading;
  final bool isSuccess;
  final Color color = Colors.blue;
  final Function onPressed;
  final String text;

  ButtonLoading(
      {Key key, this.isLoading, this.onPressed, this.text, this.isSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading || isSuccess ? null : onPressed,
      elevation: 4.0,
      minWidth: double.infinity,
      height: 50.0,
      color: color,
      child: _setUpButtonChild(),
    );
  }

  Widget _setUpButtonChild() {
    if (isLoading) {
      return SizedBox(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ),
        height: 30.0,
        width: 30.0,
      );
    }

    if (isSuccess) {
      return Icon(Icons.check, color: Colors.white);
    }

    return new Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
}
