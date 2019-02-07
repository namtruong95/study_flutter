import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/src/global_scope.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;

  @override
  AuthenticationAuthenticated({@required this.token}) {
    GlobalScope().token = this.token;
  }

  String getToken() {
    return token;
  }

  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
