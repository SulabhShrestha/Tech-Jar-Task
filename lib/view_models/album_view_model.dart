import 'package:tech_jar/models/album_model.dart';
import 'package:tech_jar/services/album_web_services.dart';

class AlbumViewModel {
  final AlbumWebServices _albumWebServices = AlbumWebServices();

  Future<List<AlbumModel>> fetchAlbums() async {
    try {
      final response = await _albumWebServices.fetchAlbums();
      List<AlbumModel> albums = [];

      for (var album in response) {
        albums.add(AlbumModel.fromJson(album));
      }

      return albums;
    } catch (e) {
      rethrow;
    }
  }

  // fetch photos
  Future<List<dynamic>> fetchPhotos(int albumId) async {
    try {
      final response = await _albumWebServices.fetchPhotos(albumId);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
