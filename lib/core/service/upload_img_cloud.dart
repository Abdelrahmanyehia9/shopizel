import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadToCloud({required File image})async{
  String imgName = FirebaseAuth.instance.currentUser!.uid  ;
  Reference storage = FirebaseStorage.instance.ref("FashionModels/$imgName.jpg") ;
  await storage.putFile(image) ;
  String downloadedImg = await storage.getDownloadURL() ;
  return downloadedImg ;
}
