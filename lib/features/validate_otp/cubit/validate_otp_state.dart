part of 'validate_otp_cubit.dart';

class ValidateOtpState extends Equatable {
  final OtpInput otp;
  final bool resendCalled;
  final FormzStatus status;

  const ValidateOtpState({
    this.status = FormzStatus.pure,
    this.otp = const OtpInput.pure(),
    this.resendCalled = false,
  });

  @override
  List<Object> get props => [otp];

  ValidateOtpState copyWith(
      {FormzStatus? status, OtpInput? otp, bool? resendCalled}) {
    return ValidateOtpState(
      status: status ?? this.status,
      otp: otp ?? this.otp,
      resendCalled: resendCalled ?? this.resendCalled,
    );
  }
}
