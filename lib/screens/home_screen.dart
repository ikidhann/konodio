import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konodio/cubit/user_cubit.dart';

import '../data/datasources/remote_datasource.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Users"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
                key: Key("center"), child: CircularProgressIndicator());
          }
          if (state is UserLoaded) {
            final data = state.users;
            return ListView.builder(
              key: const Key("list"),
              itemCount: data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index].avatar),
                  ),
                  title: Text(
                    '${data[index].first_name} ${data[index].last_name}',
                  ),
                  subtitle: Text(data[index].email),
                );
              },
            );
          }
          if (state is UserError) {
            return Center(
              key: const Key("UserError"),
              child: Text(state.error),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
