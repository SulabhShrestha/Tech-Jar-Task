import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/comment_model.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/providers/all_users_provider.dart';
import 'package:tech_jar/providers/post_comments_provider.dart';
import 'package:tech_jar/providers/user_data_provider.dart';
import 'package:tech_jar/view_models/comment_view_model.dart';

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
        await CommentViewModel().getAllCommentsForPost(widget.postModel.id);
    totalComments = allComments.length;
  }

  @override
  Widget build(BuildContext context) {
    final postComments = ref
        .watch(postCommentsProvider)
        .where((comment) => comment.postId == widget.postModel.id)
        .toList();

    final user = ref.watch(allUsersProvider).allUsers.firstWhere(
          (user) => user.uid == widget.postModel.userId,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Column(
        children: [
          // Post details
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
              child: Column(
                children: [
                  // user profile
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(user.username.split("").first),
                    ),
                    title: Text(user.username),
                    subtitle: Text(user.email),
                  ),
                  ListTile(
                    title: Text(widget.postModel.title),
                    subtitle: Text(widget.postModel.body),
                  ),
                ],
              ),
            ),
          ),

          // Post's comments
          Expanded(
            child: FutureBuilder<List<CommentModel>>(
                future: CommentViewModel()
                    .getAllCommentsForPost(widget.postModel.id),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            "All comments",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        for (var comment in postComments)
                          Card(
                            child: ListTile(
                              title: Text(comment.name),
                              subtitle: Text(comment.body),
                            ),
                          ),
                        for (var comment in snapshot.data!)
                          Card(
                            child: ListTile(
                              title: Text(comment.name),
                              subtitle: Text(comment.body),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
          ),

          // Commenting area
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Card(
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
