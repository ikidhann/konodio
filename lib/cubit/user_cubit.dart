import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konodio/data/datasources/dio_helper.dart';
import 'package:konodio/data/models/user.dart';

import '../data/datasources/remote_datasource.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void getProfiles() async {
    emit(UserLoading());
    DioHelper.getData(url: 'users').then((value) {
      if (value.statusCode == 200) {
        DataUser dataUser = DataUser.fromJson(value.data);
        emit(UserLoaded(dataUser.data));
      }
    }).catchError((e) {
      emit(UserError(e.toString()));
    });
  }

  void getProfilesTest(Dio dio) async {
    emit(UserLoading());

    var data = await dio.get("https://reqres.in/api/users");

    if (data != null) {
      emit(UserLoadedTest(data.data));
    } else {
      emit(UserError(data.statusMessage!));
    }

    // DioHelper.getDataTest(url: 'users', dia: dio).then((value) {
    //   if (value.statusCode == 200) {
    //     emit(UserLoadedTest(value.data));
    //   }
    // }).catchError((e) {
    //   emit(UserError(e.toString()));
    // });
  }
}
