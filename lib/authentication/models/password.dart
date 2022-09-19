import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
  RegExp(r'^[A-Za-z\d*@#$_-]{6,}$');

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value) || value.isNotEmpty
        ? null
        : PasswordValidationError.invalid;
  }
}