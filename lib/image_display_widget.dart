import 'package:flutter/material.dart';
import 'package:wikimedia_image_demo/image_service.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String title;

  const ImageDisplayWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images for $title'),
      ),
      body: FutureBuilder<List<String>>(
        future: ImageService.fetchImagesFromTitle(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.network(snapshot.data![index]),
                  );
                },
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
