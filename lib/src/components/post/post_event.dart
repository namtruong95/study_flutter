import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/src/models/post.dart';

abstract class PostEvent extends Equatable {}

class Fetch extends PostEvent {
  @override
  String toString() => 'Fetch';
}

class Refetch extends PostEvent {
  @override
  String toString() => 'Refetch';
}

class FetchPostFromBucket extends PostEvent {
  final List<Post> posts;

  FetchPostFromBucket({@required this.posts});

  @override
  String toString() => 'FetchPostLocal';
}
