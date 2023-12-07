import 'package:flutter/material.dart';
import 'package:tech_jar/models/album_model.dart';
import 'package:tech_jar/view_models/album_view_model.dart';

import 'pages/album_photo_displaying_page.dart';

/// Displaying album of userid 2 only
class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Page'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Column(
        children: [
          FutureBuilder<List<AlbumModel>>(
              future: AlbumViewModel().fetchAlbums(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: List.generate(snapshot.data!.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AlbumPhotoDisplayingPage(
                                    albumModel: snapshot.data![index],
                                  )));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Text(
                                snapshot.data![index].id.toString(),
                                style: const TextStyle(
                                  fontSize: 48,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
