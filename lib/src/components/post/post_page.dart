import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter/src/commons/bottom_loader.dart';

import 'package:study_flutter/src/components/post/post.dart';
import 'package:study_flutter/src/models/post.dart';

class PostPage extends StatefulWidget {
  final PageStorageBucket bucket;

  const PostPage({Key key, @required this.bucket}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc();
  final _scrollThreshold = 200.0;

  _PostPageState() {
    _scrollController.addListener(_onScroll);
  }

  @override
  void initState() {
    final posts =
        widget.bucket.readState(context, identifier: ValueKey('Post'));
    if (posts != null) {
      _postBloc.dispatch(FetchPostLocal(posts: posts));
    } else {
      _postBloc.dispatch(Fetch());
    }
    super.initState();
  }

  Future<void> _refresh() {
    _postBloc.dispatch(Refetch());

    return Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BlocBuilder(
          bloc: _postBloc,
          builder: (BuildContext context, PostState state) {
            if (state is PostUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostError) {
              return Center(
                child: Text('failed to fetch posts'),
              );
            }
            if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return Center(
                  child: Text('no posts'),
                );
              }

              widget.bucket.writeState(context, state.posts,
                  identifier: ValueKey('Post'));

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.posts.length
                        ? Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: BottomLoader(),
                          )
                        : PostWidget(post: state.posts[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.posts.length
                      : state.posts.length + 1,
                  controller: _scrollController,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
