import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid_email }

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? _validateEmail(entry: value) : EmailValidationError.empty;
  }

  EmailValidationError? _validateEmail({entry}) {
    return entry.isNotEmpty == true ? null : EmailValidationError.empty;
  }
}