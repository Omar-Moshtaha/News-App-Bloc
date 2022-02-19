import 'package:dio/dio.dart';

class Dio_Helpers {
  static Dio? dio;

  static inti() {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://newsapi.org/", receiveDataWhenStatusError: true),
    );
  }

  static Future<Response?> getdata(
      {required String mothed, Map<String, dynamic>? qeruy}) async {
    return await dio?.get(mothed, queryParameters: qeruy);
  }
// void get()
}
