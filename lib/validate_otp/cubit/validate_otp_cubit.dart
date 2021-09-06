import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/form_inputs/otp.dart';

part 'validate_otp_state.dart';

class ValidateOtpCubit extends Cubit<ValidateOtpState> {
  ValidateOtpCubit() : super(ValidateOtpState(otp: OtpInput.pure()));

  void submit() {
    emit(ValidateOtpState(otp: state.otp));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  newOtp(String otp) {
    emit(state.copyWith(otp: OtpInput.dirty(otp)));
  }

}
