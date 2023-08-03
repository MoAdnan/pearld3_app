import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}

extension EmailErrorExtension<T> on EmailValidationError {
  String get errorMessage {
    if (this == EmailValidationError.empty) {
      return 'Field is empty';
    } else if (this == EmailValidationError.invalid) {
      return 'Please enter valid email';
    } else {
      return '';
    }
  }
}
