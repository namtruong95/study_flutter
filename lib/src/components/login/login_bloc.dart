import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:study_flutter/src/components/login/login.dart';
import 'package:study_flutter/src/components/authentication/authentication.dart';
import 'package:study_flutter/src/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = new AuthRepository();
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final String token = await authRepository.login(
          email: event.email,
          password: event.password,
        );

        yield LoginSuccess();
        await Future.delayed(Duration(milliseconds: 500));

        authenticationBloc.dispatch(LoggedIn(token: token));
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
