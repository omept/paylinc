part of 'validate_otp_cubit.dart';

class ValidateOtpState extends Equatable {
  final OtpInput otp;
  final FormzStatus status;

  const ValidateOtpState({
    this.status = FormzStatus.pure,
    this.otp = const OtpInput.pure(),
  });


  @override
  List<Object> get props => [this.otp];

  ValidateOtpState copyWith({
    FormzStatus? status,
    OtpInput? otp
  }) {
    return ValidateOtpState(
      status: status ?? this.status,
      otp: otp ?? this.otp,
    );
  }
}