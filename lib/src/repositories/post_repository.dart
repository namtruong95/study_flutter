import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_flutter/src/models/post.dart';
import 'package:http/http.dart' as http;
import 'http_repository.dart';

class PostRepository {
  final HttpRepository httpRepo = new HttpRepository(httpClient: http.Client());

  Future<List<Post>> getListPost({
    @required int startIndex,
    @required int limit,
  }) async {
    final response = await httpRepo.get(
        'posts', {'_start': startIndex.toString(), '_limit': limit.toString()});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    }

    throw Exception('error fetching posts');
  }
}
