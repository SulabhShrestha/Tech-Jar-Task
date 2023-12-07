import 'package:flutter/material.dart';
import 'package:tech_jar/views/home_page/home_page.dart';
import 'package:tech_jar/views/post_page/post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Jar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => const HomePage(),
        "/post": (_) => const PostPage(),
      },
    );
  }
}
