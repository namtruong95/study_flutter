import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/src/app.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  // BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}
