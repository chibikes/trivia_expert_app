import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/login/login.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin:Alignment.topCenter, end:Alignment.bottomCenter,colors: [Colors.white70, Colors.blue], ),

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: LoginForm(

            ),
          ),
        ),
      ),
    );
  }
}
