import 'package:flutter/material.dart';
import 'package:study_flutter/src/components/post/post.dart';

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: PostPage(),
    );
  }
}
