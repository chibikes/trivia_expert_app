import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value.trim());
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } on Exception {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: 'Login failed'));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Error logging in'));
    } on Exception {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Error logging in'));
    }
  }

  Future<void> signUpWithCredentials() async {
    try {
      await _authenticationRepository.signUp(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          signUpStatus: SignUpStatus.signedUp));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } on Exception {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Could not complete sign up'));
    }
  }
}
