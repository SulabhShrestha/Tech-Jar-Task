import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/providers/all_users_provider.dart';

class AllUserDisplayPage extends ConsumerWidget {
  const AllUserDisplayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = ref.watch(allUsersProvider).allUsers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All user'),
      ),
      body: ListView.builder(
        itemCount: allUsers.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(allUsers[index].username),
            subtitle: Text(allUsers[index].email),
          );
        },
      ),
    );
  }
}
