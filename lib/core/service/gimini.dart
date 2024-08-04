import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../utils/app_constants.dart';

class GeminiHelper{

  static final  model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: AppConstants.geminiApiKey);

  static  Future<String?> geminiTextAndPhoto({required File image , required String text})async{
    final photo = await image.readAsBytes() ;

    final prompt = TextPart(text);
    final imageParts = [
      DataPart('image/jpeg', photo),
    ];
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    return  response.text ;
  }
  static Future<String?> geminiText({required String text}) async {

    final content = [Content.text(text)];
    final response = await model.generateContent(content);
    return response.text ;
  }


}