import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_jar/utils/constants.dart';

class UserWebServices {
  Future<List<dynamic>> getAllUser() async {
    try {
      final response = await http.get(
        Uri.parse(Constants().urls.allUsers),
      );

      return jsonDecode(response.body);
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String uid) async {
    try {
      final response = await http.get(
        Uri.parse("${Constants().urls.allUsers}/$uid"),
      );

      var data = jsonDecode(response.body);
      return {
        'name': data['name'],
        'email': data['email'],
      };
    } catch (e) {
      rethrow;
    }
  }
}
