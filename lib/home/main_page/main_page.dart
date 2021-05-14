import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/home/main_page/cubit/main_page_cubit.dart';
import 'package:trivia_expert_app/home/main_page/tabbed_pages.dart';
import 'package:trivia_expert_app/login/login.dart';


class MainPage extends StatelessWidget {
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => MainPage());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold( /// Bottom navigation widget state is ephemeral so no need for blocs

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => MainPageCubit(),
          child: HomePage(),
        ),
      ),
      bottomNavigationBar: HomePage(),
    );
  }
}
