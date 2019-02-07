import 'dart:io';

import 'package:flutter/material.dart';
import 'http_repository.dart';

class AuthRepository {
  final HttpRepository httpRepo = new HttpRepository();

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final res = await httpRepo.post('/store/api/v1/auth/admin/login',
          {'email': email, 'password': password});

      return res['access_token'];
    } catch (e) {
      if (e is SocketException) {
        throw new Exception('No Internet Connection');
      }

      throw e;
    }
  }
}
