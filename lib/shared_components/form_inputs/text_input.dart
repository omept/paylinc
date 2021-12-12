import 'package:formz/formz.dart';

enum TextInputValidationError { empty }

class TextInput extends FormzInput<String, TextInputValidationError> {
  const TextInput.pure() : super.pure('');
  const TextInput.dirty([String value = '']) : super.dirty(value);

  @override
  TextInputValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TextInputValidationError.empty;
  }
}
