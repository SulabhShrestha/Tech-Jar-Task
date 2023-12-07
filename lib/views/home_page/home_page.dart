/// Displays List of posts
///
import 'package:flutter/material.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/view_models/post_view_model.dart';
import 'package:tech_jar/views/post_page/post_page.dart';
import 'package:tech_jar/views/user_page/user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Jar'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const UserPage();
              }));
            },
            icon: const Icon(Icons.person),
          ),
        ],
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
                  return ListTile(
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
                    subtitle: Text(snapshot.data![index].body),
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
