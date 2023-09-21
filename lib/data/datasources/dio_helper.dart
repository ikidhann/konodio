import 'package:dio/dio.dart';
import 'package:konodio/data/models/user.dart';

class DioHelper{
  static Dio? dio;
  static String? token;

  static init() async {
    dio = Dio(BaseOptions(
      baseUrl: 'https://reqres.in/api/',
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
  }

  static Future<DataUser> getData({required String url}) async {
    final response = await dio!.get(url);
    print(response.data);
    return DataUser.fromJson(response.data);
  }
}