import 'dart:developer';

import 'package:riverpod/riverpod.dart';
import 'package:tech_jar/models/comment_model.dart';

/// stores the state of the comments of all posts
///

final postCommentsProvider =
    StateNotifierProvider<PostCommentsProvider, List<CommentModel>>(
        (ref) => PostCommentsProvider());

class PostCommentsProvider extends StateNotifier<List<CommentModel>> {
  PostCommentsProvider() : super([]);

  void addComment(CommentModel comment) {
    log("adding");
    state = [...state, comment];
  }
}
