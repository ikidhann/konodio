import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konodio/cubit/user_cubit.dart';
import 'package:konodio/data/datasources/dio_helper.dart';
import 'package:konodio/data/models/user.dart';
import 'package:mocktail/mocktail.dart';

import 'package:konodio/screens/home_screen.dart';
import 'package:konodio/cubit/user_cubit.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

class MockUserState extends Fake implements UserState {}

void main() {
  group("HomeScreen Testing", () {
    late final UserCubit userCubit;
    late final DataUser dataUser;
    List<User> list = [
      User(
          id: 0,
          email: "test@email.com",
          first_name: "test",
          last_name: "test",
          avatar: "test")
    ];

    setUpAll(() {
      userCubit = MockUserCubit();
    });

    test("getProfiles", () async {
      userCubit.getProfiles();
      DioHelper.getData(url: 'users').then((value) {
        if (value.statusCode == 200) {
          dataUser = DataUser.fromJson(value.data);
        }
      }).catchError((e) {
        print("Error");
      });
      when(() => userCubit.getProfiles())
          .thenAnswer((invocation) => UserLoaded(dataUser.data));
    });

    testWidgets("Widget HomeScreen Test", (WidgetTester tester) async {
      when(() => userCubit.state)
          .thenAnswer((invocation) => UserLoaded(dataUser.data));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserCubit>(
            create: (_) => UserCubit(),
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.pump(Duration(seconds: 5));

      expect(
          find.descendant(
              of: find.byType(BlocBuilder<UserCubit, UserState>),
              matching: find.byKey(Key("UserError"))),
          findsOneWidget);
    });
  });
}
