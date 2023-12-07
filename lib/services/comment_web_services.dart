import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tech_jar/utils/constants.dart';

/// Handles all the comment related web services
///
class CommentWebServices {
  /// Adds new comment to the post
  ///
  /// Returns the decoded json data if the response is successful
  /// which in the in the form of Map<String, dynamic>
  Future<void> addComment(Map<String, dynamic> details) async {
    log("comment details $details");
    try {
      await http.post(
        Uri.parse(Constants().urls.commentsForPost(details["postId"])),
        body: jsonEncode(details),
      );
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }

  /// Returning decoded all post's comments json data if the response is successful
  /// which in the in the form of List<dynamic>
  Future<List<dynamic>> getAllCommentsForPost(int postId) async {
    try {
      final response =
          await http.get(Uri.parse(Constants().urls.commentsForPost(postId)));
      return jsonDecode(response.body);
    } catch (e) {
      rethrow; // This will throw the error to the caller
    }
  }
}
