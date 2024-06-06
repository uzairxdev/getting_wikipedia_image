import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ImageService {
  static Future<List<String>> fetchImagesFromTitle(String title) async {
    final encodedTitle = Uri.encodeComponent(title.replaceAll(' ', '_'));
    final String url =
        'https://en.wikipedia.org/w/api.php?action=query&prop=images&titles=$encodedTitle&format=json';

    final response = await http.get(Uri.parse(url));

    log(url);
    List<String> imageUrls = [];

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final pages = jsonResponse['query']['pages'];

      for (var page in pages.values) {
        if (page['images'] != null) {
          for (var image in page['images']) {
            final String imageUrl = await fetchImageUrl(image['title']);
            imageUrls.add(imageUrl);
          }
        }
      }
    } else {
      throw Exception('Failed to load images');
    }

    return imageUrls;
  }

  static Future<String> fetchImageUrl(String imageTitle) async {
    final encodedImageTitle = Uri.encodeComponent(imageTitle);
    final String url =
        'https://en.wikipedia.org/w/api.php?action=query&titles=$encodedImageTitle&prop=imageinfo&iiprop=url&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final imageInfo =
          jsonResponse['query']['pages'].values.first['imageinfo'].first;

      return imageInfo['url'];
    } else {
      throw Exception('Failed to load image URL');
    }
  }
}
