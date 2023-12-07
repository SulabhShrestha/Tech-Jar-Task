class Constants {
  final _Urls urls = _Urls();
}

class _Urls {
  String get allPosts => 'https://jsonplaceholder.typicode.com/posts';
  String getAllCommentsForPost(int postId) => '$allPosts/$postId/comments';
}
