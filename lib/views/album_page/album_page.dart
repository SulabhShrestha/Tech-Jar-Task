import 'package:flutter/material.dart';
import 'package:tech_jar/models/album_model.dart';
import 'package:tech_jar/view_models/album_view_model.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Page'),
      ),
      body: Column(
        children: [
          Text("Albums of user '2'"),
          FutureBuilder<List<AlbumModel>>(
              future: AlbumViewModel().fetchAlbums(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: List.generate(snapshot.data!.length, (index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            child: Text(
                              snapshot.data![index].id.toString(),
                              style: TextStyle(
                                fontSize: 48,
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
