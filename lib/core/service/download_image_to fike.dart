import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<File> downloadImage(String imageUrl, String fileName) async {
  try {
    // Get the temporary directory
    final directory = await getTemporaryDirectory();

    // Create the file path
    final filePath = '${directory.path}/$fileName';

    // Download the image
    Dio dio = Dio();
    Response response = await dio.get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    // Write the bytes to a file
    final file = File(filePath);
    await file.writeAsBytes(response.data);

    return file;
  } catch (e) {
    throw Exception('Failed to download image: $e');
  }
}
