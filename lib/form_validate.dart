class FormValidate {
  static final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"
  );
  static final passwordRegExp =
  RegExp(r"^(?=.*[A-Z])(?=.*[a-z])[A-Za-z\d\w\W]{6,}$");
}