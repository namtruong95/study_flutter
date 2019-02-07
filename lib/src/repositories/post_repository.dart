import 'package:flutter/material.dart';
import 'package:study_flutter/src/models/post.dart';
import 'http_repository.dart';

class PostRepository {
  static final PostRepository _postRepository = new PostRepository._internal();
  factory PostRepository() => _postRepository;
  PostRepository._internal();

  final HttpRepository httpRepo = new HttpRepository();

  Future<List<Post>> getListPost({
    @required int startIndex,
    @required int limit,
  }) async {
    final List<dynamic> res = await httpRepo.get(
        'posts', {'_start': startIndex.toString(), '_limit': limit.toString()});

    return res.map((rawPost) {
      return Post(
        id: rawPost['id'],
        title: rawPost['title'],
        body: rawPost['body'],
      );
    }).toList();
  }
}
