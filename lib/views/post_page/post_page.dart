import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/comment_model.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/providers/post_comments_provider.dart';
import 'package:tech_jar/providers/user_data_provider.dart';
import 'package:tech_jar/services/comment_view_model.dart';
import 'package:tech_jar/view_models/post_view_model.dart';

/// Displays specific post details including comments too
///
class PostPage extends ConsumerStatefulWidget {
  final PostModel postModel;

  const PostPage({
    super.key,
    required this.postModel,
  });

  @override
  ConsumerState<PostPage> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  final TextEditingController _commentController = TextEditingController();
  int totalComments = 0;

  @override
  void initState() {
    initializeComments();
    super.initState();
  }

  Future<void> initializeComments() async {
    final allComments =
        await PostViewModel().getAllCommentsForPost(widget.postModel.id);
    totalComments = allComments.length;
    ref.watch(postCommentsProvider.notifier).initializeComments(allComments);
  }

  @override
  Widget build(BuildContext context) {
    final postComments = ref.watch(postCommentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Column(
        children: [
          // Post details
          Card(
            child: ListTile(
              title: Text(widget.postModel.title),
              subtitle: Text(widget.postModel.body),
            ),
          ),

          // Post comments
          Expanded(
            child: ListView.builder(
              itemCount: postComments.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(postComments[index].name),
                    subtitle: Text(postComments[index].body),
                  ),
                );
              },
            ),
          ),

          // Commenting area
          Card(
            child: ListTile(
              title: Text('Comment'),
              subtitle: TextField(
                controller: _commentController,
                onSubmitted: (comment) {
                  addComment(comment);
                  _commentController.clear();
                },
                decoration: InputDecoration(
                  hintText: 'Write your comment here',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addComment(String comment) {
    final userData = ref.watch(userDataProvider);
    final commentModel = CommentModel(
      postId: widget.postModel.id,
      id: totalComments + 1,
      name: userData["name"],
      email: userData["email"],
      body: comment,
    );

    try {
      CommentViewModel().addComment(details: commentModel.toJson());
      ref.watch(postCommentsProvider.notifier).addComment(commentModel);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
