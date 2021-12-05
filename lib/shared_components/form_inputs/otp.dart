import 'package:formz/formz.dart';

enum OtpValidationError { empty, invalid_otp}

class OtpInput extends FormzInput<String, OtpValidationError> {
  const OtpInput.pure() : super.pure('');
  const OtpInput.dirty([String value = '']) : super.dirty(value);

  @override
  OtpValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? _validateOtp(entry: value) : OtpValidationError.empty;
  }

  OtpValidationError? _validateOtp({entry}) {
    return entry.isNotEmpty == true ? null : OtpValidationError.invalid_otp;
  }
}