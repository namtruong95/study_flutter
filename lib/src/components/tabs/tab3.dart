import 'package:flutter/material.dart';
import 'package:study_flutter/src/components/contacts/contacts.dart';

class Tab3 extends StatelessWidget {
  final PageStorageBucket bucket;

  Tab3({Key key, @required this.bucket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContactsPage(
      bucket: bucket,
    );
  }
}
