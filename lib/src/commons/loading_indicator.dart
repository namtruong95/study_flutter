import 'package:flutter/material.dart';
import 'package:study_flutter/src/commons/container_bg.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContainerBg(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
