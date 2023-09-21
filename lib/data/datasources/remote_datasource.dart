import 'package:dio/dio.dart';
import '../models/user.dart';

class RemoteDataSource{
  final dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api'));

  Future<DataUser> getUsers() async {
    final response = await dio.get('/users');
    print(response.data);
    return DataUser.fromJson(response.data);
  }
}