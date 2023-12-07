import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_jar/utils/constants.dart';

class PostWebServices {
  /// Returning decoded json data if the response is successful
  /// which in the in the form of List<dynamic>
  Future<List<dynamic>> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse(Constants().urls.allPosts));
      return jsonDecode(response.body);
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }
}
