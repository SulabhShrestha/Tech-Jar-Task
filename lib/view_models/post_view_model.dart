import 'package:tech_jar/models/comment_model.dart';
import 'package:tech_jar/models/post_model.dart';
import 'package:tech_jar/services/post_web_services.dart';

class PostViewModel {
  final PostWebServices _postWebServices = PostWebServices();

  // Returning all posts in the form of List<PostModel>
  Future<List<PostModel>> getAllPosts() async {
    try {
      // To be returned this
      List<PostModel> postModels = [];

      // Getting all posts and converting all to model
      List<dynamic> allPosts = await _postWebServices.getAllPosts();
      for (var post in allPosts) {
        postModels.add(PostModel.fromJson(post));
      }

      // Returning the list of post models
      return postModels;
    } catch (e) {
      rethrow;
    }
  }

  // Returning all comments for a post in the form of List<PostModel>
  Future<List<CommentModel>> getAllCommentsForPost(int postId) async {
    try {
      // To be returned this
      List<CommentModel> commentModels = [];

      // Getting all comments for a post and converting all to model
      List<dynamic> allComments =
          await _postWebServices.getAllCommentsForPost(postId);
      for (var comment in allComments) {
        commentModels.add(CommentModel.fromJson(comment));
      }

      // Returning the list of post models
      return commentModels;
    } catch (e) {
      rethrow;
    }
  }
}
