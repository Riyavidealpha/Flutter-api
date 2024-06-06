import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/api_bloc.dart';
import '../model/api_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.text});
  final String text;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api handling"),
      ),
      body: SafeArea(
        child: BlocBuilder<ApiFetchBloc, ApiFetchState>(
          builder: (context, afb) {
            return SafeArea(
              child: afb is ApiFetchProgress
                  ? const CircularProgressIndicator()
                  : afb is ApiFetchFailure
                      ? Text(afb.error.toString())
                      : afb is ApiFetchSuccess
                          ? ListView.builder(
                              itemCount: afb.users.length,
                              itemBuilder: (context, index) {
                                User user = afb.users[index];
                                return ListTile(
                                  title: Text("${user.id}. ${user.name} "),
                                  subtitle: Text(user.email),
                                );
                              },
                            )
                          : Text("$afb"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.work),
        onPressed: () {
          setState(() {
            currPage = currPage + 1;
          });
          context.read<ApiFetchBloc>().add(Fetch());
        },
      ),
    );
  }
}
