import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'http_repository.dart';

class AuthRepository {
  final HttpRepository httpRepo = new HttpRepository(httpClient: http.Client());

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    final response = await httpRepo.post('/store/api/v1/auth/admin/login',
        {'email': email, 'password': password});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['access_token'];
    }

    throw Exception('error fetching posts');
  }
}
