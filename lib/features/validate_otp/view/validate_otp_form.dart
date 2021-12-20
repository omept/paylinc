import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/features/validate_otp/cubit/validate_otp_cubit.dart';

class ValidateOtpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(padding: EdgeInsets.all(12)),
          _OtpInput(),
          const Padding(padding: EdgeInsets.all(12)),
          Row(
            children: <Widget>[
              _SubmitButton(),
              _ResendOtpButton(),
            ],
          ),
          const Padding(padding: EdgeInsets.all(12))
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateOtpCubit, ValidateOtpState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('Submit'),
                onPressed: state.otp.valid
                    ? () {
                        context.read<ValidateOtpCubit>().submit();
                      }
                    : null,
              );
      },
    );
  }
}

class _ResendOtpButton extends StatefulWidget {
  @override
  State<_ResendOtpButton> createState() => _ResendOtpButtonState();
}

class _ResendOtpButtonState extends State<_ResendOtpButton> {
  // final CountdownController countdownController =
  //     Get.put(CountdownController());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateOtpCubit, ValidateOtpState>(
      builder: (context, state) {
        var otpCubit = context.read<ValidateOtpCubit>();
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ElevatedButton(
              child: Text('Resend OTP Submit'),
              onPressed: () {
                otpCubit.resendOtp();
              },
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateOtpCubit, ValidateOtpState>(
      buildWhen: (previous, current) => previous.otp != current.otp,
      builder: (context, state) {
        return TextField(
          key: const Key('votpForm_otpInput_textField'),
          onChanged: (otp) => context.read<ValidateOtpCubit>().newOtp(otp),
          // obscureText: true,
          decoration: InputDecoration(
            labelText: 'Otp',
            errorText: state.otp.invalid ? 'invalid otp' : null,
          ),
        );
      },
    );
  }
}
