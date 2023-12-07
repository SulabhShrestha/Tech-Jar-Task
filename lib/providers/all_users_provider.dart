import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/user_model.dart';

/// Stores all the users information
///
class AllUsersNotifier extends ChangeNotifier {
  List<UserModel> allUsers = [];

  void allAll(List<UserModel> users) {
    allUsers = users;
    log("All Users: $users");
    notifyListeners();
  }

  UserModel findUserById(int id) {
    return allUsers.firstWhere((user) => user.uid == id);
  }
}

final allUsersProvider = ChangeNotifierProvider<AllUsersNotifier>((ref) {
  return AllUsersNotifier();
});
