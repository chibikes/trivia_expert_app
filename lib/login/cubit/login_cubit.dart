import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:formz/formz.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : super(const LoginState());

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
    } on Exception catch(e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, exception: e.toString()));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure, exception: e.toString()));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }

  Future<void> signUpWithCredentials() async {
    try {
      await _authenticationRepository.signUp(email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch(e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, exception: e.toString()));
    }
  }
}
