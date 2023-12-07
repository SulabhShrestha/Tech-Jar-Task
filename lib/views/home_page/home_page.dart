/// Displays List of posts
///
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/providers/all_users_provider.dart';
import 'package:tech_jar/view_models/post_view_model.dart';
import 'package:tech_jar/views/post_page/post_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _allUsers = ref.watch(allUsersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Jar'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: FutureBuilder<List<PostModel>>(
        future: PostViewModel().getAllPosts(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // post added user information
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.person),
                                Text(_allUsers
                                    .findUserById(snapshot.data![index].userId)
                                    .username),
                              ],
                            ),
                          ),

                          ListTile(
                            splashColor: Colors.deepPurple,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PostPage(
                                    postModel: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            title: Text(snapshot.data![index].title),
                            subtitle: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                text: snapshot.data![index].body,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
