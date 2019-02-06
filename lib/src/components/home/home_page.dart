import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_flutter/src/components/authentication/authentication.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('logout'),
                onPressed: () {
                  authenticationBloc.dispatch(LoggedOut());
                },
              ),
              RaisedButton(
                child: Text('post'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/posts');
                },
              ),
              RaisedButton(
                child: Text('test'),
                onPressed: () async {
                  final token =
                      await authenticationBloc.userRepository.fetchToken();

                  print(token);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
