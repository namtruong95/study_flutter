import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpRepository {
  final http.Client httpClient;
  final String baseUri = 'api.sod.bla-one.net';
  final String baseUri2 = r'jsonplaceholder.typicode.com';

  HttpRepository({@required this.httpClient});

  Future<http.Response> get(String url, [paramsJson]) async {
    final uri = Uri.https(baseUri2, url, paramsJson);
    const String token = '';
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (token.isNotEmpty) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
    }

    print(headers);
    return this.httpClient.get(uri, headers: headers);
  }

  Future<http.Response> post(String url, bodyJson, [paramsJson]) async {
    var uri = Uri.https(baseUri, url);

    if (!['', null, false].contains(paramsJson)) {
      uri = Uri.https(baseUri, url, paramsJson);
    }

    const String token = '';
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (token.isNotEmpty) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
    }

    return this.httpClient.post(
          uri,
          headers: headers,
          body: json.encode(bodyJson),
        );
  }
}
