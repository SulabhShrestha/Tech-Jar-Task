class Constants {
  final _Urls urls = _Urls();
}

class _Urls {
  String get allPosts => 'https://jsonplaceholder.typicode.com/posts';
  String commentsForPost(num postId) => '$allPosts/$postId/comments';

  String get allUsers => "https://jsonplaceholder.typicode.com/users";
}
