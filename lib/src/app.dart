import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_flutter/src/commons/loading_indicator.dart';
import 'package:study_flutter/src/commons/splash_page.dart';
import 'package:study_flutter/src/components/authentication/authentication.dart';
import 'package:study_flutter/src/components/home/home.dart';
import 'package:study_flutter/src/components/login/login.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc();
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  Widget _buildState(AuthenticationState state) {
    if (state is AuthenticationUninitialized) {
      return SplashPage();
    }
    if (state is AuthenticationAuthenticated) {
      return HomePage();
    }
    if (state is AuthenticationUnauthenticated) {
      return LoginPage();
    }
    if (state is AuthenticationLoading) {
      return LoadingIndicator();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            return _buildState(state);
          },
        ),
      ),
    );
  }
}
