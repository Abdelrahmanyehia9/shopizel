import "package:dio/dio.dart" ;
import "package:shoppizel/core/utils/app_constants.dart";

class ApiHelper{

  final Dio dio  ;
  ApiHelper({required this.dio});


  Future<Map<String, dynamic>?> post(String endpoint, Map<String, dynamic> data, String contentType ) async {
    try {
      final response = await dio.post(
        AppConstants.baseUrl+endpoint,
        data: data,
        options: Options(headers: {"Content-Type":contentType}),
      );
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('An unexpected error occurred: $e');
      return null;
    }
  }
}