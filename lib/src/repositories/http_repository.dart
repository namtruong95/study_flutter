import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:study_flutter/src/global_scope.dart';

class HttpRepository {
  static final HttpRepository _httpRepository = new HttpRepository._internal();
  factory HttpRepository() => _httpRepository;
  HttpRepository._internal();

  final http.Client httpClient = new http.Client();
  final String baseUri = 'api.sod.bla-one.net';
  final String baseUri2 = 'jsonplaceholder.typicode.com';
  final JsonDecoder _decoder = new JsonDecoder();

  FutureOr<dynamic> get(String url, [paramsJson]) async {
    final uri = Uri.https(baseUri2, url, paramsJson);
    final headers = await _generateHeaders();

    return this
        .httpClient
        .get(uri, headers: headers)
        .then((http.Response response) => _handleResponse(response));
  }

  FutureOr<dynamic> post(String url, bodyJson, [paramsJson]) async {
    var uri = Uri.https(baseUri, url);

    if (!['', null, false].contains(paramsJson)) {
      uri = Uri.https(baseUri, url, paramsJson);
    }

    final headers = await _generateHeaders();

    return this
        .httpClient
        .post(
          uri,
          headers: headers,
          body: json.encode(bodyJson),
        )
        .then((http.Response response) => _handleResponse(response));
  }

  Future<Map<String, String>> _generateHeaders() async {
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final String token = GlobalScope().token;

    if (!['', null, false, 0].contains(token)) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $token');
    }

    return headers;
  }

  _handleResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      final message = _decoder.convert(res)['message'];

      throw new Exception(message ?? 'Error while fetching data');
    }

    return _decoder.convert(res);
  }
}
