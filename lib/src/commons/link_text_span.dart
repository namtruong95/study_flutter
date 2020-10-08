import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkTextSpan extends TextSpan {
  final Function onPressed;

  LinkTextSpan({TextStyle style, String url, String text, this.onPressed})
      : super(
          style: style,
          text: text ?? url,
          recognizer: TapGestureRecognizer()..onTap = onPressed,
        );
}
