/// Displays specific post details including comments too
///
import 'package:flutter/material.dart';
import 'package:tech_jar/models/comment_model.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/view_models/post_view_model.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postModel = ModalRoute.of(context)!.settings.arguments as PostModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Column(
        children: [
          // Post details
          Card(
            child: ListTile(
              title: Text(postModel.title),
              subtitle: Text(postModel.body),
            ),
          ),

          // Post comments
          FutureBuilder<List<CommentModel>>(
              future: PostViewModel().getAllCommentsForPost(postModel.id),
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
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].body),
                        ),
                      );
                    },
                  ),
                );
              }),

          // Commenting area
          const Card(
            child: ListTile(
              title: Text('Comment'),
              subtitle: TextField(
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
}
