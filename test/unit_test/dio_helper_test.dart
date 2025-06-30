import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:konodio/data/datasources/dio_helper.dart';

const successMessage = {"message": "Success"};

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  var baseUrl;

  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = 'https://reqres.in/api/users';
  });

  group("DioHelper Testing", () {
    group("Get Method", () {
      test("Get Success method", () async {
        dioAdapter.onGet('$baseUrl', (request) {
          request.reply(
            200,
            successMessage,
          );
        }, data: null, queryParameters: {}, headers: {});

        final dioHelper = DioHelper(
          dio: dio,
        );

        final response = await dioHelper.getData(url: baseUrl);

        print(response);
      });
    });
  });
}
