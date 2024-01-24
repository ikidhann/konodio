import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static String? token;

  static init() async {
    dio = Dio(BaseOptions(
      baseUrl: 'https://reqres.in/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  /// Get
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    var data = await dio!.get(url, queryParameters: query);
    print(data);
    return await dio!.get(url, queryParameters: query);
  }

  /// Get Data Test
  static Future<Response> getDataTest(
      {required String url,
      required Dio dia,
      Map<String, dynamic>? query,
      String? token}) async {
    var data = await dia.get(url, queryParameters: query);
    print(data);
    return await dia.get(url, queryParameters: query);
  }
}
