import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_jar/utils/constants.dart';

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
}
