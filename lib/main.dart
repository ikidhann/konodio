import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konodio/cubit/user_cubit.dart';
import 'package:konodio/cubit/villa_cubit.dart';
import 'package:konodio/data/datasources/dio_helper.dart';
import 'package:konodio/screens/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<VillaCubit>(
        create: (context) => VillaCubit(),
        child: HomeScreen(),
      ),
    );
  }
}
