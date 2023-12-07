import 'package:flutter/material.dart';
import 'package:tech_jar/models/user_model.dart';
import 'package:tech_jar/view_models/user_view_model.dart';

class AllUserDisplayPage extends StatelessWidget {
  const AllUserDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All user'),
      ),
      body: FutureBuilder<List<UserModel>>(
          future: UserViewModel().getAllUser(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(snapshot.data![index].username),
                  subtitle: Text(snapshot.data![index].email),
                );
              },
            );
          }),
    );
  }
}
