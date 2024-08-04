import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {

 static Future<File> downloadImage(String imageUrl, String fileName) async {
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
 static Future<String> uploadImage({required File image})async{
   String imgName = FirebaseAuth.instance.currentUser!.uid  ;
   Reference storage = FirebaseStorage.instance.ref("FashionModels/$imgName.jpg") ;
   await storage.putFile(image) ;
   String downloadedImg = await storage.getDownloadURL() ;
   return downloadedImg ;
 }





}