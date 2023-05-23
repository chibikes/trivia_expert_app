part of 'login_cubit.dart';

enum SignUpStatus { unknown, signedUp }

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = '',
    this.obscurePassword = true,
    this.signUpStatus = SignUpStatus.unknown,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String errorMessage;
  final bool obscurePassword;
  final SignUpStatus signUpStatus;

  @override
  List<Object> get props =>
      [email, password, status, errorMessage, obscurePassword, signUpStatus];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    bool? obscurePassword,
    SignUpStatus? signUpStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }
}
