part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.exception = '',
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String exception;

  @override
  List<Object> get props => [email, password, status, exception];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? exception,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }
}
