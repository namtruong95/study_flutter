import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:study_flutter/src/components/authentication/authentication.dart';
import 'package:study_flutter/src/global_scope.dart';
import 'package:study_flutter/src/repositories/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = new UserRepository();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final String token = await userRepository.fetchToken();

      if (['', null, false].contains(token)) {
        yield AuthenticationUnauthenticated();
      } else {
        yield AuthenticationAuthenticated(token: token);
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated(token: event.token);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      GlobalScope().clear();
      yield AuthenticationUnauthenticated();
    }
  }
}
