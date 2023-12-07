import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_jar/utils/constants.dart';

/// handles the fetching of albums and photos
class AlbumWebServices {
  Future<List<dynamic>> fetchAlbums() async {
    try {
      final response =
          await http.get(Uri.parse("${Constants().urls.allUsers}/2/albums"));
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> fetchPhotos(int albumId) async {
    try {
      final response = await http
          .get(Uri.parse("${Constants().urls.allAlbums}/$albumId/photos"));
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
