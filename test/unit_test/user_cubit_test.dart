import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:konodio/cubit/user_cubit.dart';
import 'package:konodio/data/datasources/dio_helper.dart';
import 'package:konodio/data/models/user.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group("Success Scenarios", () {
    late Dio dio;
    late DioAdapter dioAdapter;
    const getDataUrl = "https://reqres.in/api/users";
    List<dynamic> dataList = [
      {
        "id": 1,
        "email": "george.bluth@reqres.in",
        "first_name": "George",
        "last_name": "Bluth",
        "avatar": "https://reqres.in/img/faces/1-image.jpg"
      },
    ];

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });

    blocTest<UserCubit, UserState>(
      "When data is empty",
      setUp: (() {
        return dioAdapter.onGet(
            getDataUrl, (request) => request.reply(200, []));
      }),
      build: () => UserCubit(),
      act: (cubit) {
        cubit.getProfilesTest(dio);
      },
      wait: const Duration(milliseconds: 1000),
      expect: () => [UserLoading(), UserLoadedTest([])],
    );

    blocTest<UserCubit, UserState>(
      "When data is not empty",
      setUp: (() {
        return dioAdapter.onGet(
            getDataUrl, (request) => request.reply(200, dataList));
      }),
      build: () => UserCubit(),
      act: (cubit) {
        cubit.getProfilesTest(dio);
      },
      wait: const Duration(milliseconds: 1000),
      expect: () => [UserLoading(), UserLoadedTest(dataList)],
    );
  });
}
