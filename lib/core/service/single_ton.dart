import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shoppizel/core/database/remote/api_helper.dart';

final  getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiHelper>(ApiHelper(dio: Dio()));
}