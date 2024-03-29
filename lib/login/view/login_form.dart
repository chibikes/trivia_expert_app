import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:trivia_expert_app/widgets/trivia_icon.dart';
import '../login.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('${state.errorMessage}')),
            );
        } else if (state.status.isSubmissionSuccess &&
            state.signUpStatus == SignUpStatus.signedUp) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Account successfully created!')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 0.20 * data.height),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 0.05 * MediaQuery.of(context).size.height,
                child: _GoogleLoginButton()),
            SizedBox(height: 0.04 * data.height),
            _EmailInput(),
            SizedBox(height: 0.01 * data.height),
            _PasswordInput(),
            SizedBox(height: 0.04 * data.height),
            _SignUpButton(),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.obscurePassword != current.obscurePassword,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: state.obscurePassword,
          decoration: InputDecoration(
              labelText: 'password',
              helperText: '',
              errorText: state.password.invalid
                  ? 'password should be at least six characters'
                  : null,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<LoginCubit>().emit(
                      state.copyWith(obscurePassword: !state.obscurePassword));
                },
                icon: Icon(state.obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
              )),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('LOGIN'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFFFD600)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.read<LoginCubit>().logInWithGoogle(),
      child: Container(
        key: const Key('loginForm_googleLogin_raisedButton'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: MediaQuery.of(context).size.width * 0.20),
            Icon(FontAwesomeIcons.google, color: Colors.white),
            SizedBox(
              width: 8.0,
            ),
            const Text(
              'SIGN IN WITH GOOGLE',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xff009688),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          if (state.status == FormzStatus.valid)
            context.read<LoginCubit>().signUpWithCredentials();
        },
        key: const Key('loginForm_createAccount_flatButton'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'CREATE ACCOUNT',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }
}
