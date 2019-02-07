import 'package:flutter/material.dart';
import 'package:study_flutter/src/components/post/post.dart';

class Tab1 extends StatelessWidget {
  final PageStorageBucket bucket;

  Tab1({Key key, @required this.bucket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: PageStorageKey('Tab1'),
      resizeToAvoidBottomPadding: false,
      body: PostPage(
        bucket: this.bucket,
      ),
    );
  }
}
