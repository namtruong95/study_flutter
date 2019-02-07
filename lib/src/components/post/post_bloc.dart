import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:study_flutter/src/components/post/post.dart';
import 'package:study_flutter/src/models/post.dart';
import 'package:study_flutter/src/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepositoty = new PostRepository();

  @override
  Stream<PostEvent> transform(Stream<PostEvent> events) {
    return (events as Observable<PostEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(currentState, event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }

        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        yield PostError();
      }
    }

    if (event is FetchPostLocal) {
      yield PostLoaded(posts: event.posts, hasReachedMax: false);
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) {
    return this
        .postRepositoty
        .getListPost(startIndex: startIndex, limit: limit);
  }
}
