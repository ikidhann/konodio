import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  var baseUrl;

  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = 'https://reqres.in/api/users';
  });

  group("Dio Testing", () {
    test("Get Success method", () async {
      dioAdapter.onGet('$baseUrl', (server) {
        server.reply(200, {'message': 'Success!'});
      });

      final response = await dio.get(baseUrl);
      print(response.data); // {message: Success!}
    });
  });
}
