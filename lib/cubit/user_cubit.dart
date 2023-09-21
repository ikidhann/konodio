import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konodio/data/datasources/dio_helper.dart';
import 'package:konodio/data/models/user.dart';

import '../data/datasources/remote_datasource.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {

  final RemoteDataSource remoteDataSource;

  UserCubit({required this.remoteDataSource}) : super(UserInitial());

  void getProfiles() async{
    emit(UserLoading());
    try {
      final result = await DioHelper.getData(url: 'users');
      emit(UserLoaded(result.data));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}