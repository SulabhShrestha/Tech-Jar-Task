class AlbumModel {
  final String title;
  final int userId;
  final int id;

  AlbumModel({
    required this.title,
    required this.userId,
    required this.id,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      title: json['title'],
      userId: json['userId'],
      id: json['id'],
    );
  }
}
