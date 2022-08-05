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
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Authentication Failure: ${state.exception}')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 0.07 * data.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TriviaIcon(width: 0.10 * MediaQuery.of(context).size.width,), SizedBox(width: 2,),Text(' RIVIA EXPERT ', style: TextStyle(backgroundColor: Colors.black54, fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            ),
            SizedBox(height: 0.20 * data.height),
            SizedBox(width: MediaQuery.of(context).size.width, height: 0.05 * MediaQuery.of(context).size.height,child: _GoogleLoginButton()),
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
      buildWhen: (previous, current) => previous.password != current.password || previous.obscurePassword != current.obscurePassword,
      builder: (context, state) {
        return Stack(
          children: [
            TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: state.obscurePassword,
              decoration: InputDecoration(
                labelText: 'password',
                helperText: '',
                errorText: state.password.invalid ? 'password should be at least six characters' : null,
              ),
            ),
            Positioned(
              left: 0.85 * MediaQuery.of(context).size.width,
              top: 0.02 * MediaQuery.of(context).size.height,
              child: GestureDetector(onTap: () {
                context.read<LoginCubit>().emit(state.copyWith(obscurePassword: !state.obscurePassword));
              },child: Icon(state.obscurePassword ? Icons.visibility : Icons.visibility_off)),
            ),
          ],
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
            : RaisedButton(
          key: const Key('loginForm_continue_raisedButton'),
          child: const Text('LOGIN'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: const Color(0xFFFFD600),
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
    return RaisedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      color: theme.accentColor,
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return FlatButton(
          key: const Key('loginForm_createAccount_flatButton'),
          // onPressed: () { Navigator.of(context).push<void>(SignUpPage.route()) },
          onPressed: () {
           if (state.status == FormzStatus.valid) context.read<LoginCubit>().signUpWithCredentials();
          },
          child: Text(
            'CREATE ACCOUNT',
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    );
  }
}
