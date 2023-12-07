import 'package:flutter/material.dart';
import 'package:tech_jar/models/album_model.dart';
import 'package:tech_jar/view_models/album_view_model.dart';

/// Displays the photos from the album
///
class AlbumPhotoDisplayingPage extends StatelessWidget {
  final AlbumModel albumModel;
  const AlbumPhotoDisplayingPage({
    super.key,
    required this.albumModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album ${albumModel.id}"),
      ),
      body: FutureBuilder(
        future: AlbumViewModel().fetchPhotos(albumModel.id),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            children: List.generate(snapshot.data!.length, (index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(snapshot.data![index]["url"]),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
