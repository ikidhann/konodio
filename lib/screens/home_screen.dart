import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konodio/cubit/user_cubit.dart';
import 'package:konodio/cubit/villa_cubit.dart';

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
    context.read<VillaCubit>().getVillas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Users"),
      ),
      body: BlocBuilder<VillaCubit, VillaState>(
        builder: (context, state) {
          if (state is VillaLoading) {
            return const Center(
                key: Key("center"), child: CircularProgressIndicator());
          }
          if (state is VillaLoaded) {
            final data = state.villas;
            return ListView.builder(
              key: const Key("list"),
              itemCount: data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(
                    '${data[index].name} ${data[index].address}',
                  ),
                  subtitle: Text("Capacity: ${data[index].capacity}"),
                );
              },
            );
          }
          if (state is VillaError) {
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
