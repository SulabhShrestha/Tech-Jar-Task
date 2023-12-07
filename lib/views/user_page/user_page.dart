/// Displays information related to user
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/providers/user_data_provider.dart';

import 'pages/all_user_display_page.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Column(
        children: [
          // User details
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(userData["name"]),
              subtitle: Text(userData["email"]),
            ),
          ),

          // show all user
          Card(
            child: ListTile(
              title: const Text("Show all user"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AllUserDisplayPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
