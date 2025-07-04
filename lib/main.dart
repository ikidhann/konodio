import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konodio/cubit/user_cubit.dart';
import 'package:konodio/data/datasources/dio_helper.dart';
import 'package:konodio/data/datasources/remote_datasource.dart';
import 'package:konodio/screens/home_screen.dart';

Future<void> main() async{
  await DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<UserCubit>(
        create: (context) => UserCubit(remoteDataSource: RemoteDataSource()),
        child: HomeScreen(),
      ),
    );
  }
}

