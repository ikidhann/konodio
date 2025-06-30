import 'package:dio/dio.dart';

class DioHelper {
  Dio _dio = Dio();
  final String _baseUrl = 'https://api-rilex.aether.id/v1/';
  static String? token;

  DioHelper({Dio? dio}) {
    _dio = dio ?? Dio();
    _dio.options.baseUrl = _baseUrl;
  }

  // static init() async {
  //   _dio = Dio(BaseOptions(
  //     baseUrl: 'https://reqres.in/api/',
  //     receiveDataWhenStatusError: true,
  //   ));
  // }

  /// Get
  Future<dynamic> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    var data = await _dio.get(url, queryParameters: query);
    print(data);
    return await _dio.get(url, queryParameters: query);
  }

  /// Get Data Test
  Future<dynamic> getDataTest(
      {required String url,
      required Dio dia,
      Map<String, dynamic>? query,
      String? token}) async {
    var data = await dia.get(url, queryParameters: query);
    print(data);
    return await dia.get(url, queryParameters: query);
  }
}
