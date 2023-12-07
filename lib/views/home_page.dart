/// Displays List of posts
///
import 'package:flutter/material.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/view_models/post_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Jar'),
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}
