import 'package:tech_jar/services/comment_web_services.dart';

class CommentViewModel {
  final CommentWebServices _commentWebServices = CommentWebServices();

  // Returning all comments for a post in the form of List<PostModel>
  Future<void> addComment({required Map<String, dynamic> details}) async {
    try {
      await _commentWebServices.addComment(details);
    } catch (e) {
      rethrow;
    }
  }
}
